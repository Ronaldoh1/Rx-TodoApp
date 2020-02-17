//
//  AppDelegate.swift
//  PhotoApp
//
//  Created by Hernandez, Ronald on 2/9/20.
//  Copyright © 2020 Ronaldoh1. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let bag = DisposeBag()

        struct Student {
            var score: BehaviorRelay<Int>
        }
        
        let john = Student(score: BehaviorRelay(value: 75))
        let ron = Student(score: BehaviorRelay(value: 100))
        let mary = Student(score: BehaviorRelay(value: 85))
        
        let student = PublishSubject<Student>()
        
        student
            .asObservable()
            .flatMapLatest { $0.score }
            .subscribe(onNext: {
                print($0)
            }).disposed(by: bag)
        
        student.onNext(john)
        student.onNext(ron)
        student.onNext(mary)
        
        john.score.accept(45)
        
        // it's only observing the latest observable.... not the history of the observable.
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

