//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by David Szurma on 6/7/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

//- https://www.thedroidsonroids.com/blog/ios/rxswift-by-examples-2-observable-and-the-bind/

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    var circleView: UIView!
    let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated
    var circleViewModel: CircleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    deinit {
        print("deinit ViewController")
    }
    
    func setup() {
        // Add circle view
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .green
        view.addSubview(circleView)
        
        circleViewModel = CircleViewModel()
        // Bind the center point of the CircleView to the centerObservable
        circleView
            .rx.observe(CGPoint.self, "center")
            .bind(to: circleViewModel.centerVariable)
            .addDisposableTo(disposeBag)
        
// Subscribe to backgroundObservable to get new colors from the ViewModel.
//        circleViewModel.backgroundColorObservable
//            .subscribe(onNext: { [weak self] backgroundColor in
//                UIView.animate(withDuration: 0.3) {
//                    self?.circleView.backgroundColor = UIColor.black//backgroundColor
//                    // Try to get complementary color for given background color
//                    let viewBackgroundColor = UIColor(complementaryFlatColorOf: backgroundColor)
//                    // If it is different that the color
//                    if viewBackgroundColor != backgroundColor {
//                        // Assign it as a background color of the view
//                        // We only want different color to be able to see that circle in a view
//                       // self?.view.backgroundColor = viewBackgroundColor
//                    }
//                }
//            })
//            .addDisposableTo(disposeBag)
        
        circleViewModel.cornerRadiusObservable
            .subscribe(onNext: {  [weak self] radius in
                UIView.animate(withDuration: 0.1) {
                    self?.circleView.layer.cornerRadius = radius
                }
            }, onError: { (error) in
                print("cornerRadiusObservable error: \(error)")
            }, onCompleted: {
                print("cornerRadiusObservable .onCompleted()")
            }) {
                print("cornerRadiusObservable .onDisposed()")
        }.addDisposableTo(disposeBag)
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }
    
    func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }
}
