//
//  CategoriesVC.swift
//  BestNews
//
//  Created by Saska Rauhala on 21.3.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var newsTypes = [String]()
    var newsTypesArr = [NewsTypes]()
    var filteredTypes = [NewsTypes]()
    
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
        
        newsTypes = ["Sport news", "Technology news", "Lifestyle news ", "Fashion news ", "Political news", "Business news", "Satire news", "National news", "International news", "World news", "Culture news", "Economic news", "Local news", "Regional news", "Ents & Celeb news"]
        
    
        for i in 0..<newsTypes.count {
            
            let type = NewsTypes(name: newsTypes[i])
            
            newsTypesArr.append(type)
            
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if inSearchMode {
            return filteredTypes.count
        }
        
        return newsTypesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "typesCell") as? NewsTypesCell {
        
            if inSearchMode {
              
                let newsTypes = filteredTypes[indexPath.row]
                
                cell.configureCell(newsTypes: newsTypes)
                
            } else {
                let newsTypes = newsTypesArr[indexPath.row]
                
                cell.configureCell(newsTypes: newsTypes)
            }
            

            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if inSearchMode {
            let news = filteredTypes[indexPath.row]
            performSegue(withIdentifier: "categoryNews", sender: news)
        } else {
            let news = newsTypesArr[indexPath.row]
            performSegue(withIdentifier: "categoryNews", sender: news)
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destination = segue.destination as? CategoryNews {
            if let newType = sender as? NewsTypes {
                destination.newType = newType
            }
            
        }
       
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
           
            inSearchMode = false
            
            view.endEditing(true)
            tableView.reloadData()
        } else {
            
            inSearchMode = true
            
            let text = searchBar.text!
            
            filteredTypes = newsTypesArr.filter({$0.name.range(of: text) != nil})
            tableView.reloadData()
            
        }
        
    }
}
