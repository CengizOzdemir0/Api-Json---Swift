//
//  ViewController.swift
//  Api Json Project - Swift
//
//  Created by CengizOzdemir on 5.06.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cadLabel: UILabel!
    
    @IBOutlet weak var chfLabel: UILabel!
    
    @IBOutlet weak var gdpLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        //1-) Request & Session
        //2-) Response & Data
        //3-) Parsing & JSON Seri
        
        // 1. adım
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=9d1f8cf40991cc19ea9ce2b1ce610ad6")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            // hata mesajı varsa
            if error != nil {
               let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
              //  2. adım
                if data != nil {
                    do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        //ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                               // print(rates)
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(cad)"
                            }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF : \(chf)"
                            }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gdpLabel.text = "GBP : \(gbp)"
                            }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                            }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "UST : \(usd)"
                            }
                                if let turksih = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(turksih)"
                            }
                        }
                        
                    }
                    } catch {
                        print("error")
                    }
                }
                
                
            }
        }
        task.resume()
        
    }
}

