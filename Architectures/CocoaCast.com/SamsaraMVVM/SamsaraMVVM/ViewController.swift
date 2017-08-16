//
//  ViewController.swift
//  SamsaraMVVM
//
//  Created by David Szurma on 8/2/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueProfileViewController {
            if let viewController = segue.destination as? ProfileViewController {
                viewController.profileViewModel = ProfileViewModel(withProfile: Profile())
            }
        }
    }

}

