//
//  TempCell.swift
//  FocusHandling
//
//  Created by David Szurma on 8/2/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

import UIKit

class TempCell: UICollectionViewCell {
    
    @IBOutlet weak var contentLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if (self.isFocused)
        {
            print("focused")
//            backgroundColor?.withAlphaComponent(0.5)
            contentLab.text = "Focused"
            // Apply focused appearence,
            // e.g scale both of them using transform or apply background color
        }
        else
        {
            contentLab.text = "--"
            print("normal")
//            backgroundColor?.withAlphaComponent(1.0)

            // Apply normal appearance
        }
        
        
//        if context.nextFocusedItem === self {
//            coordinator.addCoordinatedAnimations({
//                
//                self.layer.shadowOpacity = 1.0
//                self.layer.shadowOffset = CGSize.zero
//                self.layer.shadowRadius = 5
//                self.layer.shadowColor = UIColor.white.cgColor
//                
//                self.backgroundColor = UIColor.gray
//                self.contentView.backgroundColor?.withAlphaComponent(1.0)
//                
//            }, completion: nil)
//            
//            
//        }
//        else if context.previouslyFocusedItem === self {
//            coordinator.addCoordinatedAnimations({
//                
//                
//                self.layer.shadowOpacity = 0
//                self.contentView.backgroundColor?.withAlphaComponent(0.5)
//                
//                
//            }, completion: nil)
//        }
    }
}
