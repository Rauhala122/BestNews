//
//  CategoryNews.swift
//  BestNews
//
//  Created by Saska Rauhala on 25.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Alamofire

class CategoryNews: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoryType: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var news = [News]()
    private var _newType: NewsTypes!

    var newType: NewsTypes {
        get {
            return _newType
        } set {
            _newType = newValue
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        categoryType.text = newType.name
    
        tableView.delegate = self
        tableView.dataSource = self
        
        
        if newType.name == "Sport news" {
            
            downloadNewsData(source: "bbc-sports")
            downloadNewsData(source: "football-italia")
            downloadNewsData(source: "nfl-news")
            downloadNewsData(source: "sky-sports-news")
            downloadNewsData(source: "talksport")
            downloadNewsData(source: "the-sport-bible")
        } else if newType.name == "Technology news" {
            downloadNewsData(source: "wired-de")
            downloadNewsData(source: "ars-technica")
            downloadNewsData(source: "engadget")
            downloadNewsData(source: "gruenderszene")
        } else if newType.name == "Business news" {
            downloadNewsData(source: "cnbc")
            downloadNewsData(source: "bloomberg")
        }
    
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "categoryNewsCell") as? NewsCell {
            
            let new = news[indexPath.row]
            
            cell.configureCell(news: new)
            
            return cell
            
        } else {
            return NewsCell()
        }
    }
    
    // Download news function
    
    func downloadNewsData(source: String) {
        Alamofire.request("https://newsapi.org/v1/articles?source=\(source)&sortBy=top&apiKey=e37344124622489bae904176a38ae5e8").responseJSON { (response) in
            if let dict = response.value as? Dictionary<String, AnyObject> {
                
                if let articles = dict["articles"] as? [Dictionary<String, AnyObject>] {
                    
                    
                    for i in 0..<articles.count {
                        if let article = articles[i] as? Dictionary<String, AnyObject> {
                            let id = NSUUID().uuidString
                           
                            var title: String?
                            var desc: String?
                            var imageURL: String?
                            
                            
                            if let title1 = article["title"] as? String {
                                title = title1
                            } else {
                                title = ""
                            }
                            if let desc1 = article["description"] as? String {
                                desc = desc1
                            } else {
                                desc = ""
                            }
                            if let imageURL1 = article["urlToImage"] as? String {
                                imageURL = imageURL1
                            } else {
                                imageURL = ""
                                
                                
                            }
                     
                            let new = News(title: title!, desc: desc!, imageURL: imageURL!, source: source, postKey: id)
                            self.news.append(new)
                            
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
   
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
