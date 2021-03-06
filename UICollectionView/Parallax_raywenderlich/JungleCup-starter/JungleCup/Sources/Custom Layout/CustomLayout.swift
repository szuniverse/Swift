/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

final class CustomLayout: UICollectionViewLayout {
  
  // 1
  enum Element: String {
    case header
    case menu
    case sectionHeader
    case sectionFooter
    case cell
    
    var id: String {
      return self.rawValue
    }
    
    var kind: String {
      return "Kind\(self.rawValue.capitalized)"
    }
  }
  
  // 2
  override public class var layoutAttributesClass: AnyClass {
    return CustomLayoutAttributes.self
  }
  
  // 3
  override public var collectionViewContentSize: CGSize {
    return CGSize(width: collectionViewWidth, height: contentHeight)
  }
  
  // 4
  var settings = CustomLayoutSettings()
  private var oldBounds = CGRect.zero
  private var contentHeight = CGFloat()
  private var cache = [Element: [IndexPath: CustomLayoutAttributes]]()
  private var visibleLayoutAttributes = [CustomLayoutAttributes]()
  private var zIndex = 0
  
  // 5
  private var collectionViewHeight: CGFloat {
    return collectionView!.frame.height
  }
  
  private var collectionViewWidth: CGFloat {
    return collectionView!.frame.width
  }
  
  private var cellHeight: CGFloat {
    guard let itemSize = settings.itemSize else {
      return collectionViewHeight
    }
    
    return itemSize.height
  }
  
  private var cellWidth: CGFloat {
    guard let itemSize = settings.itemSize else {
      return collectionViewWidth
    }
    
    return itemSize.width
  }
  
  private var headerSize: CGSize {
    guard let headerSize = settings.headerSize else {
      return .zero
    }
    
    return headerSize
  }
  
  private var menuSize: CGSize {
    guard let menuSize = settings.menuSize else {
      return .zero
    }
    
    return menuSize
  }
  
  private var sectionsHeaderSize: CGSize {
    guard let sectionsHeaderSize = settings.sectionsHeaderSize else {
      return .zero
    }
    
    return sectionsHeaderSize
  }
  
  private var sectionsFooterSize: CGSize {
    guard let sectionsFooterSize = settings.sectionsFooterSize else {
      return .zero
    }
    
    return sectionsFooterSize
  }
  
  private var contentOffset: CGPoint {
    return collectionView!.contentOffset
  }
}

// MARK: - LAYOUT CORE PROCESS
extension CustomLayout {
  
  override public func prepare() {
    
    // 1
    guard let collectionView = collectionView,
      cache.isEmpty else {
        return
    }
    // 2
    prepareCache()
    contentHeight = 0
    zIndex = 0
    oldBounds = collectionView.bounds
    let itemSize = CGSize(width: cellWidth, height: cellHeight)
    
    // 3
    let headerAttributes = CustomLayoutAttributes(forSupplementaryViewOfKind: Element.header.kind, with: IndexPath(item: 0, section: 0))
    prepareElement(size: headerSize, type: .header, attributes: headerAttributes)
    
    // 4
    let menuAttributes = CustomLayoutAttributes( forSupplementaryViewOfKind: Element.menu.kind, with: IndexPath(item: 0, section: 0))
    prepareElement(size: menuSize, type: .menu, attributes: menuAttributes)
    
    // 5
    for section in 0 ..< collectionView.numberOfSections {
      
      let sectionHeaderAttributes = CustomLayoutAttributes( forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: IndexPath(item: 0, section: section))
      prepareElement(size: sectionsHeaderSize, type: .sectionHeader, attributes: sectionHeaderAttributes)
      
      for item in 0 ..< collectionView.numberOfItems(inSection: section) {
        let cellIndexPath = IndexPath(item: item, section: section)
        let attributes = CustomLayoutAttributes(forCellWith: cellIndexPath)
        let lineInterSpace = settings.minimumLineSpacing
        attributes.frame = CGRect(
          x: 0 + settings.minimumInteritemSpacing,
          y: contentHeight + lineInterSpace,
          width: itemSize.width,
          height: itemSize.height
        )
        attributes.zIndex = zIndex
        contentHeight = attributes.frame.maxY
        cache[.cell]?[cellIndexPath] = attributes
        zIndex += 1
      }
      
      let sectionFooterAttributes = CustomLayoutAttributes(
        forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: IndexPath(item: 1, section: section))
      prepareElement( size: sectionsFooterSize, type: .sectionFooter, attributes: sectionFooterAttributes)
    }
    
    // 6
    updateZIndexes()
  }
  
  override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    if oldBounds.size != newBounds.size {
      cache.removeAll(keepingCapacity: true)
    }
    return true
  }
  
  private func prepareCache() {
    cache.removeAll(keepingCapacity: true)
    cache[.header] = [IndexPath: CustomLayoutAttributes]()
    cache[.menu] = [IndexPath: CustomLayoutAttributes]()
    cache[.sectionHeader] = [IndexPath: CustomLayoutAttributes]()
    cache[.sectionFooter] = [IndexPath: CustomLayoutAttributes]()
    cache[.cell] = [IndexPath: CustomLayoutAttributes]()
  }
  
  private func prepareElement(size: CGSize, type: Element, attributes: CustomLayoutAttributes) {
    //1
    guard size != .zero else {
      return
    }
    //2
    attributes.initialOrigin = CGPoint(x:0, y: contentHeight)
    attributes.frame = CGRect(origin: attributes.initialOrigin, size: size)
    // 3
    attributes.zIndex = zIndex
    zIndex += 1
    // 4
    contentHeight = attributes.frame.maxY
    // 5
    cache[type]?[attributes.indexPath] = attributes
  }
  
  private func updateZIndexes(){
    guard let sectionHeaders = cache[.sectionHeader] else {
      return
    }
    var sectionHeadersZIndex = zIndex
    for (_, attributes) in sectionHeaders {
      attributes.zIndex = sectionHeadersZIndex
      sectionHeadersZIndex += 1
    }
    cache[.menu]?.first?.value.zIndex = sectionHeadersZIndex
  }
}

//MARK: - PROVIDING ATTRIBUTES TO THE COLLECTIONVIEW
extension CustomLayout {
  
  //1
  public override func layoutAttributesForSupplementaryView(
    ofKind elementKind: String,
    at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    
    switch elementKind {
    case UICollectionElementKindSectionHeader:
      return cache[.sectionHeader]?[indexPath]
      
    case UICollectionElementKindSectionFooter:
      return cache[.sectionFooter]?[indexPath]
      
    case Element.header.kind:
      return cache[.header]?[indexPath]
      
    default:
      return cache[.menu]?[indexPath]
    }
  }
  
  //2
  override public func layoutAttributesForItem(
    at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[.cell]?[indexPath]
  }
  
  //3
  override public func layoutAttributesForElements(
    in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    guard let collectionView = collectionView else {
      return nil
    }
    visibleLayoutAttributes.removeAll(keepingCapacity: true)
    // 1
    let halfHeight = collectionViewHeight * 0.5
    let halfCellHeight = cellHeight * 0.5
    // 2
    for (type, elementInfos) in cache {
      for (indexPath, attributes) in elementInfos {
        // 3
        attributes.parallax = .identity
        attributes.transform = .identity
        // 4
        updateSupplementaryViews(type, attributes: attributes, collectionView: collectionView, indexPath: indexPath)
        if attributes.frame.intersects(rect) {
          // 5
          if type == .cell,
            settings.isParallaxOnCellsEnabled {
            updateCells(attributes, halfHeight: halfHeight, halfCellHeight: halfCellHeight)
          }
          visibleLayoutAttributes.append(attributes)
        }
      }
    }
    return visibleLayoutAttributes
  }
  
  private func updateSupplementaryViews(_ type: Element, attributes: CustomLayoutAttributes, collectionView: UICollectionView, indexPath: IndexPath) {
    // 1
    if type == .sectionHeader,
      settings.isSectionHeadersSticky {
      let upperLimit =
        CGFloat(collectionView.numberOfItems(inSection: indexPath.section))
          * (cellHeight + settings.minimumLineSpacing)
      let menuOffset = settings.isMenuSticky ? menuSize.height : 0
      attributes.transform =  CGAffineTransform(
        translationX: 0,
        y: min(upperLimit, max(0, contentOffset.y - attributes.initialOrigin.y + menuOffset)))
    }
      // 2
    else if type == .header, settings.isHeaderStretchy {
      let updatedHeight = min(collectionView.frame.height, max(headerSize.height, headerSize.height - contentOffset.y))
      let scaleFactor = updatedHeight / headerSize.height
      let delta = (updatedHeight - headerSize.height) / 2
      let scale = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
      
      var translation: CGAffineTransform!
      
      // print("delta: \(delta)")
      print("scale: \(contentOffset.y/headerSize.height)")
      // print("scaleFactor: \(headerSize.height)")

      if scale.a > 1.0 {
        translation = CGAffineTransform(translationX: 0, y: min(contentOffset.y, headerSize.height) + delta)
        attributes.transform = scale.concatenating(translation)
        
      } else {
        attributes.frame = CGRect(x: 0, y: -contentOffset.y/headerSize.height, width: attributes.frame.width, height: attributes.frame.height)
      }
      if settings.isAlphaOnHeaderActive {
        attributes.headerOverlayAlpha = min( settings.headerOverlayMaxAlphaValue, contentOffset.y / headerSize.height)
      }
    }
      // 3
    else if type == .menu,
      settings.isMenuSticky {
      attributes.transform = CGAffineTransform(translationX: 0, y: max(attributes.initialOrigin.y, contentOffset.y) - headerSize.height)
    }
  }
  
  private func updateCells(_ attributes: CustomLayoutAttributes, halfHeight: CGFloat, halfCellHeight: CGFloat) {
    // 1
    let cellDistanceFromCenter = attributes.center.y - contentOffset.y - halfHeight
    
    // 2
    let parallaxOffset = -(settings.maxParallaxOffset * cellDistanceFromCenter)
      / (halfHeight + halfCellHeight)
    // 3
    let boundedParallaxOffset = min(max(-settings.maxParallaxOffset, parallaxOffset), settings.maxParallaxOffset)
    // 4
    attributes.parallax = CGAffineTransform(translationX: 0, y: boundedParallaxOffset)
  }
}
