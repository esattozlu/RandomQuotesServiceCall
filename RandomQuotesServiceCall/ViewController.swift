//
//  ViewController.swift
//  RandomQuotesServiceCall
//
//  Created by Hasan Esat Tozlu on 20.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var queryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func getRandomQueryButtonClicked(_ sender: Any) {
        NetworkManager.getRandomQuotes { randomQuery, error in
            guard let randomQuery = randomQuery else {
                self.queryLabel.text = error?.localizedDescription
                return
            }
                DispatchQueue.main.async {
                    self.queryLabel.text = randomQuery.en
                }
            }
        }
    }


