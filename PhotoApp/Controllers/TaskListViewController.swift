//
//  TaskListViewController.swift
//  PhotoApp
//
//  Created by Hernandez, Ronald on 2/16/20.
//  Copyright © 2020 Ronaldoh1. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    private let tasks = BehaviorRelay<[Task]>(value: [])
    
    private var filteredTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @IBAction func addNewTask(_ sender: Any) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let navController = segue.destination as? UINavigationController, let addTVC = navController.viewControllers.first as? AddTaskViewController else {
            return
        }
        
        addTVC.taskSubjectObservable
            .subscribe(onNext: { [unowned self] task in
                
                let priority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex - 1)
                var existingTask = self.tasks.value
                existingTask.append(task)
                self.tasks.accept(existingTask)
                self.filterTask(by: priority)
                
        }).disposed(by: disposeBag)
    }
    
    @IBAction func priorityChanged(_ sender: Any) {
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTask(by: priority)
    }
    
    private func filterTask(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority!}
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
                }).disposed(by: disposeBag)
        }
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let task = filteredTasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    
}


extension TaskListViewController: UITableViewDelegate {
    
}
