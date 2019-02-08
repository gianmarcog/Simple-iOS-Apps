//
//  ViewController.swift
//  TableViewHP
//
//  Created by Gianmarco Giretti on 06.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var personList = [PersonBank]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Methode die zu Beginn immer aufgerufen wird
        
        self.title = ""
        // Der Title der über der TableView steht
        
        tableView.dataSource = self
        // Dieses Objekt wird benötig, damit die Daten für die TableView bereitgestellt werden
        
        tableView.delegate = self
        // Dieses Objekt wird benötigt, damit man die auftretenden Zellen in der TableView verändern kann (größe,breite)
        
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "tableViewCell")
    }
    // Mit der Konstanten nibName geben wir der xib Datei einen Namen. Deshalb als nibName: "TableViewCell"
    // Das bundle ist für die nib(xib) Datei zuständig. Es sucht die xib Datei. Wenn man "nil" auswählt, verwendetes das main Bundle, in dem Fall die TableViewCell
    // Das Register wird verwendet um ein nib Objekt einer Zelle zuzweisen und diesem eine Identifikation gibt
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonBank.init().houseData.count
    }
    // Hier wird festgestellt wv. Abschnitte es in der TableView gibt
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.commonInit("hp_\(indexPath.item)", title: PersonBank.init().houseData[indexPath.item], sub: PersonBank.init().wordsData[indexPath.item])
        return cell
    }
    // Das "dequeueReusableCell" Objekt nimmt eine Zelle von deinem Storyboard und erlaubt es dir es zu benützen wenn du es aufrufst. Richtet den Text in der tableViewCell ein.
    // CommonInit sorgt dafür, dass jede Zelle der IndexPath reihenfolge nein Bild vom Assets bekommt. Außerdem sorgt es dafür, dass in der Reihenfolge der Arrays oben die Beschreibung dazu passt.

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    //Hier wird die Zellengröße in Pixel festgelegt
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        //ViewController wird erstellt (Für die zweite Seite auf die man dann weiter geleitet wird)
        
        vc.commonInit("hp_bg_\(indexPath.item)", title: PersonBank.init().houseData[indexPath.item], details: PersonBank.init().personData[indexPath.item])
        //Bild wird der 2.View zugeteilt
        
        self.navigationController?.pushViewController(vc, animated: true)
        //pushed den ViewController wenn er was findet
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        // graut das geklickte aus
    }
}

