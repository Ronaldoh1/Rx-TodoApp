//
//  AddTaskViewController.swift
//  PhotoApp
//
//  Created by Hernandez, Ronald on 2/16/20.
//  Copyright © 2020 Ronaldoh1. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    private let taskSubject = PublishSubject<Task>()
    
    // to get access to this from other places
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveTask(_ sender: Any) {
        guard let priority = Priority(rawValue: prioritySegmentedControl.selectedSegmentIndex), let title = self.taskTextField.text else {
            return
        }
        
        let task = Task(title: title, priority:     priority)
        
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
