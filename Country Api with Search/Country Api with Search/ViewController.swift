//
//  ViewController.swift
//  Country Api with Search
//
//  Created by macOS Mojave on 19/3/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit
var countryName: [String] = []

class ViewController: UIViewController, UITabBarDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    var filterArray: [String]?

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var tableViewOutlet: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetchening  json data
        fetching_json()
       // tableViewOutlet.rowHeight = UITableView.automaticDimension

        //Hide menu
        menuView.isHidden = true
        
    }
    func fetching_json() {
        let jsonString = "https://restcountries.eu/rest/v2/all"
        guard let url = URL(string: jsonString) else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                return
            }
            do{
                let countryList = try JSONDecoder().decode([Info].self , from: data)
                print(countryList)
                print("Downloaded!")
                //print(countryList[0])
                for i in 0..<countryList.count{
                    countryName.append(countryList[i].name)
                }
                self.filterArray = countryName
                DispatchQueue.main.async {
                    self.tableViewOutlet.reloadData()
                }
            }catch let error{
                print(error.localizedDescription)
            }
            
            }.resume()
    }
    // Showing data in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = filterArray?.count{
            return count
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! customTableViewCell
        if let value = self.filterArray?[indexPath.row]{
            cell.nameLabel.text = value
        }
        return cell
    }
    
    // For searching
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text?.isEmpty)!{
            self.filterArray = countryName
        }else{
            self.filterArray = countryName.filter({ $0.lowercased().contains(searchBar.text!.lowercased())})
        }
        self.tableViewOutlet.reloadData()
    }
    //Menu Action
    

    @IBAction func MenuAction(_ sender: UIBarButtonItem) {
        if menuView.isHidden != true{
            menuView.isHidden = true
        }else{
            menuView.isHidden = false
        }
    }
    
}

