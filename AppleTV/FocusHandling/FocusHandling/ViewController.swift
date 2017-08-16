//
//  ViewController.swift
//  FocusHandling
//
//  Created by David Szurma on 8/2/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cells = [TempCell]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "TempCell", bundle: nil), forCellWithReuseIdentifier: "TempCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionView.collectionViewLayout.invalidateLayout()
        
        
        for cell in cells {
            let focusGuide = UIFocusGuide()
            
            view.addLayoutGuide(focusGuide)

            if cell.tag == 0 {
                focusGuide.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
                focusGuide.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
                focusGuide.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
                focusGuide.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            } else if cell.tag == 1 {
                focusGuide.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 0).isActive = true
                focusGuide.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 20).isActive = true
                focusGuide.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
                focusGuide.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            }
            else if cell.tag == 2 {
                focusGuide.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10).isActive = true
                focusGuide.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 0).isActive = true
                focusGuide.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
                focusGuide.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            }
            
            focusGuide.preferredFocusEnvironments = [cell]

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TempCell", for: indexPath) as! TempCell
        
        
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor.red
        } else if indexPath.row == 1 {
            cell.backgroundColor = UIColor.green
        } else if indexPath.row == 2 {
            cell.backgroundColor = UIColor.blue
        }
        cell.tag = indexPath.row
        cell.setNeedsFocusUpdate()
        cell.updateFocusIfNeeded()
        
        cells.append(cell)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected")
    }
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [collectionView.cellForItem(at: IndexPath(row: 0, section: 0))!]
    }
    
    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
        let _ = context.previouslyFocusedView as! TempCell
        
        //        if focusedButton.tag == 0 {
        if context.focusHeading == .left {
//            return false
        }
        //        }
        
        return super.shouldUpdateFocus(in: context)
    }
}

