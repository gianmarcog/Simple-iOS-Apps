//
//  DetailVC.swift
//  TableViewHP
//
//  Created by Gianmarco Giretti on 07.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailsPerson: UILabel!
    
    var imageName: String!
    var details: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = UIImage(named: self.imageName)
        detailsPerson.text = details
        // Do any additional setup after loading the view.
    }

    func commonInit(_ imageName: String, title: String, details: String) {
        self.imageName = imageName
        self.title = title
        self.details = details
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
