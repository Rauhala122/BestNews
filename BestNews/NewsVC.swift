 //
//  NewsVC.swift
//  BestNews
//
//  Created by Saska Rauhala on 21.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase

class NewsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var news = [News]()
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadNewsData(source: "bbc-news")
        downloadNewsData(source: "reuters")
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as? NewsCell {
            
            let new = news[indexPath.row]
       
            cell.configureCell(news: new)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func downloadNewsData(source: String) {
        
        Alamofire.request("https://newsapi.org/v1/articles?source=\(source)&sortBy=top&apiKey=e37344124622489bae904176a38ae5e8").responseJSON { (response) in
            
            if let dict = response.value as? Dictionary<String, AnyObject> {
                
               
                if let articles = dict["articles"] as? [Dictionary<String, AnyObject>] {
                   
                    for i in 0..<articles.count {
                        
                        if let article = articles[i] as? Dictionary<String, AnyObject> {
                            
                            let id = NSUUID().uuidString
                            let title = article["title"] as? String
                            let desc = article["description"] as? String
                            let url = article["url"] as? String
                            let imageURL = article["urlToImage"] as? String
                     
                            let new = News(title: title!, desc: desc!, imageURL: imageURL!, source: source, postKey: id)
                            
                            self.news.append(new)
                            self.tableView.reloadData()
                            
                        }
                        
                    }
                }
            }
        }

    }
    
    
   
}
