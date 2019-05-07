//
//  ViewController.swift
//  CountryInfo
//
//  Created by macOS Mojave on 31/3/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit
var countryInfo: [Info] = []
var countryName: [String] = []
var searching = false

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    var filterArray: [String]?
    var myIndex : Int?
    

    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuViewLeading: NSLayoutConstraint!
    @IBOutlet weak var searchOutlet: UISearchBar!
    @IBOutlet weak var SegmentOutlet: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetchening  json data
        fetching_json()
        //tableView.rowHeight = UITableView.automaticDimension
        //Initially hide the search bar
        //searchOutlet.isHidden = true
        
        //Hide MenuBar
        menuViewLeading.constant = -285
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
                countryInfo = countryList
                print("Downloaded!")
                //print(countryList[0])
                for i in 0..<countryList.count{
                    countryName.append(countryList[i].name)
                    
                    countryInfo.append(countryList[i])
                    //print(countryInfo[i].languages)
                    
                }
                
                //countryInfo = countryList
                self.filterArray = countryName
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch let error{
                print(error)
            }
            
            }.resume()
    }
    
    // Showing data in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            let count = filterArray?.count
            return count!
        }else{
            
            return countryName.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! customTableViewCell
        if let value = self.filterArray?[indexPath.row]{
            cell.countryLabel.text = value
        }
        //print("country info : ",countryInfo)
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        if (searchBar.text?.isEmpty)!{
            self.filterArray = countryName
        }else{
            self.filterArray = countryName.filter({ $0.lowercased().contains(searchBar.text!.lowercased())})
        }
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("enter didSelectRowAt")
        myIndex = indexPath.row
        performSegue(withIdentifier: "secondView", sender: self)
        
        //Passing data using pushViewController
      /* let vc = storyboard?.instantiateViewController(withIdentifier: "secondView") as! secondViewController
        self.navigationController?.pushViewController(vc, animated: true)
        if searching{
            var searchIndex = 0
            for i in 0..<countryName.count{
                if filterArray![indexPath.row] == countryInfo[i].name{
                    searchIndex = i
                }
        }
            vc.countryDetails = countryInfo[searchIndex]
            vc.alpha2Code = countryInfo[searchIndex].alpha2Code
        }else{
            vc.countryDetails = countryInfo[myIndex!]
                        //        sendData.nameValue = countryInfo[myIndex!].name
            vc.alpha2Code = countryInfo[myIndex!].alpha2Code
            } */
        
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendData = segue.destination as! secondViewController
        if searching{
            var searchIndex = 0
            for i in 0..<countryName.count{
                if filterArray![myIndex!] == countryInfo[i].name{
                    searchIndex = i
                }
            sendData.countryDetails = countryInfo[searchIndex]
            sendData.alpha2Code = countryInfo[searchIndex].alpha2Code
            }
        }else{
            sendData.countryDetails = countryInfo[myIndex!]
            //        sendData.nameValue = countryInfo[myIndex!].name
            sendData.alpha2Code = countryInfo[myIndex!].alpha2Code
        }

    }



    @IBAction func MenuAction(_ sender: UIBarButtonItem) {
        if menuShowing{
            menuViewLeading.constant = -285
            UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            })
        }else{
            menuViewLeading.constant = 0
            UIView.animate(withDuration: 0.3, animations : {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }

////    @IBAction func searchButton(_ sender: UIButton) {
////        if searchOutlet.isHidden == true{
////            searchOutlet.isHidden = false
////        }
//        //else{
////            searchOutlet.isHidden = true
////        }
//    }
}

