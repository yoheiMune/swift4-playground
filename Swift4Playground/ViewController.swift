//
//  ViewController.swift
//  Swift4Playground
//
//  Created by Munesada Yohei on 2017/11/16.
//  Copyright © 2017年 Munesada Yohei. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let samples = [
        ("001 TinderUI Sample", TinderUIViewController())
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift4 Playground"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//MARK:- TableViewDatasouce
extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return samples.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "swift4-playground-list")
        if cell == nil {
            cell = UITableViewCell()
        }
        
        cell?.textLabel?.text = samples[indexPath.row].0
        
        return cell!
    }
}

//MARK:- TableViewDelegate
extension ViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = samples[indexPath.row].1
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
