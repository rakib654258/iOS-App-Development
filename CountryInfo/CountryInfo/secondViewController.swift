//
//  secondViewController.swift
//  CountryInfo
//
//  Created by macOS Mojave on 9/4/19.
//  Copyright © 2019 macOS Mojave. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    var countryDetails: Info?
    var alpha2Code: String = ""
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var alpha2: UILabel!
    @IBOutlet weak var calling: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var subreg: UILabel!
    @IBOutlet weak var population: UILabel!
    @IBOutlet weak var latlng: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var borders: UILabel!
    @IBOutlet weak var currencies: UILabel!
    @IBOutlet weak var languages: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        valueAssign()
        // Do any additional setup after loading the view.
    }
    
    func valueAssign(){
        if let imageUrl = URL(string:  "https://countryflags.io/\(alpha2Code)/shiny/64.png"){
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.img.image = image
                    }
                }
            }
        }
        
        name.text = countryDetails?.name
        alpha2.text = countryDetails?.alpha2Code
        calling.text = countryDetails?.callingCodes[0]
        capital.text = countryDetails?.capital
        region.text = countryDetails?.region
        subreg.text = countryDetails?.subregion
        population.text! = "\(String(describing: countryDetails?.population))"
        latlng.text = "\(countryDetails?.latlng)" //as? String
//        area.text = String(describing: countryDetails?.area!)
        if let area = countryDetails?.area{
            self.area.text = "\(area)"
        }
        time.text = countryDetails?.timezones[0]
        //borders.text = countryDetails?.borders[0]
        currencies.text = "\(String(describing: countryDetails?.currencies[0]))"
        languages.text = "\(String(describing: countryDetails?.languages[0]))"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
