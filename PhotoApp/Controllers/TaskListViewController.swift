//
//  TaskListViewController.swift
//  PhotoApp
//
//  Created by Hernandez, Ronald on 2/16/20.
//  Copyright © 2020 Ronaldoh1. All rights reserved.
//

import Foundation
import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @IBAction func addNewTask(_ sender: Any) {
        
    }
    
}

extension TaskListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    
}


extension TaskListViewController: UITableViewDelegate {
    
}
