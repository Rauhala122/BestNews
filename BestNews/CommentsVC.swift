//
//  CommentsVC.swift
//  BestNews
//
//  Created by Saska Rauhala on 12.4.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit


class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   
    var btnTag: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell")
        
        return cell!
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true) 
        
        
    }

    
    
}
