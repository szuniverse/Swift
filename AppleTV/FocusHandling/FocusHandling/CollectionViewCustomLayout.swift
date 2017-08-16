//
//  EpgGridLayout.swift
//  EPG
//
//  Created by Adnan Aftab on 2/14/15.
//  Copyright (c) 2015 CX. All rights reserved.
//

import UIKit

final class CollectionViewCustomLayout: UICollectionViewLayout {
    
    // MARK: Properties
    private var xPos:CGFloat = 0
    private var yPos:CGFloat = 0
    private var framesInfo = [IndexPath: String]()
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        if cache.isEmpty {
            
            cache.removeAll()
            
            calculateFramesForAllPrograms()
            let cellLayoutInfo = NSMutableDictionary()
            
            for index in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(row: index, section: 0)
                let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                itemAttributes.frame = frameForItemAtIndexPath(indexPath)
                cellLayoutInfo[indexPath] = itemAttributes
                cache.append(itemAttributes)
                

            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> (UICollectionViewLayoutAttributes!) {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frameForItemAtIndexPath(indexPath)
        return attributes
    }
    
    //OK
    func calculateFramesForAllPrograms() {
        
        for i in 0..<collectionView!.numberOfItems(inSection: 0) {
            
            var width: CGFloat = 200
            let height: CGFloat = 100

            if i == 0 {
                width = 400
                xPos = 0
                yPos = 0
            } else if i == 1 {
                xPos = 0
                yPos = height
                width -= 10
            } else if i == 2 {
                xPos = width + 10
                yPos = height
                width -= 10
            }
            
            
            let frame = CGRect(x: xPos, y: yPos, width: width, height: height)
            let rectString = NSStringFromCGRect(frame)
            let indexPath = IndexPath(row: i, section: 0)
            framesInfo[indexPath] = rectString
//            xPos = xPos + width
//            yPos += height
        }
    }
    
    func frameForItemAtIndexPath(_ indexPath : IndexPath) -> CGRect {
        guard let rectString = framesInfo[indexPath] else { return CGRect.zero }
        return CGRectFromString(rectString)
    }
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: 400, height: 200)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return !collectionView!.bounds.size.equalTo(newBounds.size)
    }
    
    override func invalidateLayout() {
        xPos = 0
        yPos = 0
        super.invalidateLayout()
    }
    
}
