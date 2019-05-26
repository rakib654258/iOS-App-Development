//
//  ViewController.swift
//  News Reader
//
//  Created by macOS Mojave on 18/5/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var myIndex: Int?
    //var articles: Articles?
//    var ArticleArray: [Articles] = []
        var ArticleArray = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchArticlesJSON()
    }
    
    func fetchArticlesJSON(){
        let jsonUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=bb1270b8046e4a26b6dbdc87b4527e6e"
        guard let url = URL(string: jsonUrl) else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil, response != nil else{
                print("Something is wrong!")
                return
            }

            do{
                let article = try JSONDecoder().decode(Articles.self, from: data)
                //self.ArticleArray = [article]
                self.ArticleArray = article.articles
                print("Downloaded!")
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
//                self.ArticleArray.append(article)
//
            }catch let error{
                print(error)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ArticleArray.count
        
    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleTableViewCell
        cell.titleView.text = ArticleArray[indexPath.row].title
        cell.descriptionView.text = ArticleArray[indexPath.row].description
        cell.authorView.text = ArticleArray[indexPath.row].author ?? "UnKnown"
        cell.dateView.text = ArticleArray[indexPath.row].publishedAt
        //print("url:" + ArticleArray[indexPath.row].url!)
        //print(ArticleArray)
        if ArticleArray[indexPath.row].urlToImage != nil{
            if let imageURL = URL(string: ArticleArray[indexPath.row].urlToImage!){
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.imgView.image = image
                        }
                    }
                }
            }
            
        }else{
            print("Doesn't contain a imageURL!")
        }
//        tableView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webView") as! WebViewViewController
//        webVC.urlString = self.ArticleArray[indexPath.row].url
//        //webVC.name = self.ArticleArray[indexPath.row].title
//        self.present(webVC, animated: true, completion: nil)
        myIndex = indexPath.row
        //perform Segue with storyboard ID
        performSegue(withIdentifier: "webView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sendData = segue.destination as! WebViewViewController
        sendData.urlString = ArticleArray[myIndex!].url
    }


}

