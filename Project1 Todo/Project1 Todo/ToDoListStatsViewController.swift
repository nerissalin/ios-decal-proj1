//
//  ToDoListStatsViewController.swift
//  Project1 Todo
//
//  Created by Everest Shi on 3/1/16.
//  Copyright © 2016 Nerissa Lin. All rights reserved.
//

import UIKit

class ToDoListStatsViewController: UIViewController {
    
    var Completed: Int = 0

    @IBOutlet weak var toDoCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoCountLabel.text = String(Completed)
    }
    
}