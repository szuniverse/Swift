//
//  ProfileViewController.swift
//  SamsaraMVVM
//
//  Created by David Szurma on 8/2/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

import UIKit

let segueProfileViewController = "segueProfileViewController"
let profileDefaultTableViewCell = "profileDefaultTableViewCell"
let profileSwitchTableViewCell = "ProfileSwitchTableViewCell"

class ProfileViewController: UIViewController, UITableViewDataSource {

    var profileViewModel: ProfileViewModel!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: profileDefaultTableViewCell)
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ProfileSection.count()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ProfileSection(rawValue: section) else { return 1 }
        
        switch section {
        case .WarmUp:
            return profileViewModel.numberOfRowsForSegmentOfType(.WarmUp)
        case .CoolDown:
            return profileViewModel.numberOfRowsForSegmentOfType(.CoolDown)
        default: return 1
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ProfileSection(rawValue: section) else { return "" }
        return section.sectionTitle()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ProfileSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Time:
            return cellForTimeSectionForRowAtIndexPath(indexPath)
        case .WarmUp:
            return cellForWarmUpSectionForRowAtIndexPath(indexPath)
        case .CoolDown:
            return cellForCoolDownSectionForRowAtIndexPath(indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    private func cellForCoolDownSectionForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell {
        var result = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCellWithIdentifier(profileSwitchTableViewCell, forIndexPath: indexPath) as? ProfileSwitchTableViewCell {
                cell.mainLabel.text = "Enabled"
                cell.switchControl.on = profileViewModel.segmentOfTypeEnabled(.CoolDown)
                
                cell.switchControlHandler = { (sender) in
                    // Helpers
                    var indexPaths = [NSIndexPath]()
                    
                    // Fetch Current Number of Rows
                    let currentNumberOfRows = self.profileViewModel.numberOfRowsForSegmentOfType(.CoolDown)
                    
                    // Update Profile
                    self.profileViewModel.setSegmentOfType(.CoolDown, enabled: sender.on)
                    
                    // Fetch New Number of Rows
                    let newNumberOfRows = self.profileViewModel.numberOfRowsForSegmentOfType(.CoolDown)
                    
                    if sender.on { // Insert Rows
                        for row in (currentNumberOfRows)..<(newNumberOfRows) {
                            indexPaths.append(NSIndexPath(forRow: row, inSection: indexPath.section))
                        }
                        
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                        
                    } else { // Delete Rows
                        for row in (newNumberOfRows)..<(currentNumberOfRows) {
                            indexPaths.append(NSIndexPath(forRow: row, inSection: indexPath.section))
                        }
                        
                        self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                    }
                }
                
                result = cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCellWithIdentifier(profileDefaultTableViewCell, forIndexPath: indexPath) as? ProfileTableViewCell {
                cell.detailTextLabel?.text = ""
                cell.textLabel?.text = profileViewModel.timeForSegmentOfType(.CoolDown)
                
                result = cell
            }

        case 2:
            if let cell = tableView.dequeueReusableCellWithIdentifier(profileSwitchTableViewCell, forIndexPath: indexPath) as? ProfileSwitchTableViewCell {
                cell.mainLabel.text = "Bells"
                cell.switchControl.on = profileViewModel.soundOfTypeEnabled(.Begin, forSegmentOfType: .CoolDown)
                
                cell.switchControlHandler = { (sender) in
                    // Helpers
                    var indexPaths = [NSIndexPath]()
                    
                    // Fetch Current Number of Rows
                    let currentNumberOfRows = self.profileViewModel.numberOfRowsForSegmentOfType(.CoolDown)
                    
                    // Update Profile
                    self.profileViewModel.setSoundOfType(.Begin, enabled: sender.on, forSegmentOfType: .CoolDown)
                    
                    // Fetch New Number of Rows
                    let newNumberOfRows = self.profileViewModel.numberOfRowsForSegmentOfType(.CoolDown)
                    
                    if sender.on { // Insert Rows
                        for row in (currentNumberOfRows)..<(newNumberOfRows) {
                            indexPaths.append(NSIndexPath(forRow: row, inSection: indexPath.section))
                        }
                        
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                        
                    } else { // Delete Rows
                        for row in (newNumberOfRows)..<(currentNumberOfRows) {
                            indexPaths.append(NSIndexPath(forRow: row, inSection: indexPath.section))
                        }
                        
                        self.tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Top)
                    }
                }
                
                result = cell
            }

        default:
            if let cell = tableView.dequeueReusableCellWithIdentifier(profileDefaultTableViewCell, forIndexPath: indexPath) as? ProfileTableViewCell {
                cell.textLabel?.text = "Name"
                cell.detailTextLabel?.text = profileViewModel.nameSoundOfType(.Begin, forSegmentOfType: .CoolDown)
                
                result = cell
            }

        }
        
        return result
    }
    
    private func cellForTimeSectionForRowAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: profileDefaultTableViewCell, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.detailTextLabel?.text = ""
        cell.textLabel?.text = profileViewModel.timeForProfile()
        
        return cell
    }
    
    private func cellForWarmUpSectionForRowAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell {
        var result = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileSwitchTableViewCell, for: indexPath) as? ProfileSwitchTableViewCell {
                cell.mainLabel.text = "Enabled"
                cell.switchControl.on = profileViewModel.segmentOfTypeEnabled(.WarmUp)
                
                cell.switchControlHandler = { (sender) in
                    self.profileViewModel.setSegmentOfType(.WarmUp, enabled: sender.on)
                    
                    if sender.on {
                        // Insert Rows
                        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: indexPath.section)], withRowAnimation: .Top)
                        
                    } else {
                        // Delete Rows
                        self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: indexPath.section)], withRowAnimation: .Top)
                    }
                }
                
                result = cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileDefaultTableViewCell, for: indexPath) as? ProfileTableViewCell {
                cell.detailTextLabel?.text = ""
                cell.textLabel?.text = profileViewModel.timeForSegmentOfType(.WarmUp)
                
                result = cell
            }
        }
        
        return result
    }

}


// MARK: Section
enum ProfileSection: Int {
    case Time, WarmUp, CoolDown, Count
    
    static var count = {
        return ProfileSection.Count.rawValue
    }
    
    static let sectionTitles = [
        Time: "Time",
        WarmUp: "Warm Up",
        CoolDown: "Cool Down"
    ]
    
    func sectionTitle() -> String {
        if let sectionTitle = ProfileSection.sectionTitles[self] {
            return sectionTitle
        } else {
            return ""
        }
    }
    
}
