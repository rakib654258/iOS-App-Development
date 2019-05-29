//
//  MenuManager.swift
//  News Reader
//
//  Created by macOS Mojave on 29/5/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class MenuManager: NSObject, UITableViewDelegate, UITableViewDataSource {
   
    
    let blackView = UIView()
    let menuTableView = UITableView()
    let arrayOfSources = ["us", "ca","sg","sa"]
    var mainVC: ViewController?
    
    public func openMenu(){
        if let window = UIApplication.shared.keyWindow{
            blackView.frame = window.frame
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            
            //dismiss the black view
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissMenu)))
            
            let height: CGFloat = CGFloat(arrayOfSources.count * 50)
            let y = window.frame.height - height
            menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width , height: height)
            window.addSubview(blackView)
            window.addSubview(menuTableView)
            
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 1
                self.menuTableView.frame.origin.y = y
            }
        }
    }
    @objc public func dismissMenu(){
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow{
                self.menuTableView.frame.origin.y = window.frame.height
            }
        }
    }
    
    override init() {
        super.init()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        menuTableView.isScrollEnabled = false
        menuTableView.bounces = false
        
        menuTableView.register(BaseViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as UITableViewCell
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        if arrayOfSources[indexPath.row] == "us"{
            cell.textLabel?.text = "United States"
        }
        else if arrayOfSources[indexPath.row] == "ca"{
            cell.textLabel?.text = "Canada"
        }
        else if arrayOfSources[indexPath.row] == "sg"{
            cell.textLabel?.text = "Singapore"
        }
        else if arrayOfSources[indexPath.row] == "sa"{
            cell.textLabel?.text = "Saudi Arabia"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = mainVC{
            vc.source = arrayOfSources[indexPath.row].lowercased()
            vc.fetchArticlesJSON(fromSource: arrayOfSources[indexPath.row].lowercased())
            dismissMenu()
        }
    }
    

}
