/**
 * Copyright (c) 2016 Razeware LLC
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
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Foundation

class ViewController: UIViewController {
  
  @IBOutlet weak var percentLabel: UILabel!
  @IBOutlet weak var circleGraph: CircleGraphView!
  @IBOutlet weak var whiteGraph: CircleGraphView!
  @IBOutlet weak var redGraph: CircleGraphView!
  @IBAction func slider(sender: UISlider) {
    circleGraph.endArc = CGFloat(sender.value)
    percentLabel.text = String(format:" %5.2f %%",sender.value * 100)
  }
  @IBAction func whiteSlider(sender: UISlider) {
    whiteGraph.endArc = CGFloat(sender.value)
  }
  @IBAction func redSlider(sender: UISlider) {
    redGraph.endArc = CGFloat(sender.value)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
//    let backgroundTrackColor = UIColor(white: 0.15, alpha: 1.0)
//    circleGraph.arcBackgroundColor = backgroundTrackColor
//    circleGraph.arcWidth = 35.0
//    circleGraph.endArc = 0.5
//    
//    whiteGraph.arcWidth = 25.0
//    whiteGraph.arcColor = UIColor.white
//    whiteGraph.endArc = 0.5
//    whiteGraph.arcBackgroundColor = backgroundTrackColor
//    
//    redGraph.endArc = 0.25
//    redGraph.arcColor = UIColor.red
//    redGraph.arcWidth = 20.0
//    redGraph.arcBackgroundColor = backgroundTrackColor
    
  }
  
}

class CircleGraphView: UIView {
  var endArc:CGFloat = 0.0{   // in range of 0.0 to 1.0
    didSet{
      setNeedsDisplay()
    }
  }
  var arcWidth:CGFloat = 10.0
  var arcColor = UIColor.yellow
  var arcBackgroundColor = UIColor.black
  
  override func draw(_ rect: CGRect) {
//    
//    //Important constants for circle
//    let fullCircle = 2.0 * CGFloat(M_PI)
//    let start:CGFloat = -0.25 * fullCircle
//    let end:CGFloat = endArc * fullCircle + start
//    
//    //find the centerpoint of the rect
//    var centerPoint = CGPoint(x:rect.midX, y:rect.midY)
//    
//    //define the radius by the smallest side of the view
//    var radius:CGFloat = 0.0
//    if rect.width > rect.height{
//      radius = (rect.width - arcWidth) / 2.0
//    }else{
//      radius = (rect.height - arcWidth) / 2.0
//    }
//    //starting point for all drawing code is getting the context.
//    let context = UIGraphicsGetCurrentContext()
//    //set colorspace
//    let colorspace = CGColorSpaceCreateDeviceRGB()
//    //set line attributes
//    context!.setLineWidth(arcWidth)
//    context!.setLineCap(CGLineCap.round)
//    //make the circle background
//    
//    context!.setStrokeColor(arcBackgroundColor.cgColor)
//    CGContextAddEllipseInRect(context, centerPoint.x, centerPoint.y, radius, 0, fullCircle, 0)
//    context!.strokePath()
//    
//    //draw the arc
//    context!.setStrokeColor(arcColor.cgColor)
//    context!.setLineWidth(arcWidth * 0.8 )
//    //CGContextSetLineWidth(context, arcWidth)
//    CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, start, end, 0)
//    context!.strokePath()
    
  }
  
}
