//
//  PokeDexViewController.swift
//  Pokeman
//
//  Created by Terry Johnson on 10/11/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import UIKit

class PokeDexViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func mapTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
