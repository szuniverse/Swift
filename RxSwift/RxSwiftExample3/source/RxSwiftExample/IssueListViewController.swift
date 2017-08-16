//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by David Szurma on 6/7/17.
//  Copyright © 2017 SzurmaDavid. All rights reserved.
//

//- https://www.thedroidsonroids.com/blog/ios/rxswift-examples-3-networking/

import Moya
import Moya_ModelMapper
import UIKit
import RxCocoa
import RxSwift

class IssueListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<GitHub>!
    var latestRepositoryName: Observable<String> {
        return searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    var issueTrackerModel: IssueTrackerModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    
    func setupRx() {
        // First part of the puzzle, create our Provider
        provider = RxMoyaProvider<GitHub>()
        
        // Now we will setup our model
        issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)
        
        // And bind issues to table view
        // Here is where the magic happens, with only one binding
        // we have filled up about 3 table view data source methods
        issueTrackerModel
            .trackIssues()
            .bindTo(tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "issueCell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item.title
                
                return cell
            }
            .addDisposableTo(disposeBag)
        
        // Here we tell table view that if user clicks on a cell,
        // and the keyboard is still visible, hide it
        tableView
            .rx.itemSelected
            .subscribe(onNext: { indexPath in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
            })
            .addDisposableTo(disposeBag)
    }
}
