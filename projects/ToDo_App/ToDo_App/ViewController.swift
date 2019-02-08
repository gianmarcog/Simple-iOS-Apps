//
//  ViewController.swift
//  ToDo_App
//
//  Created by Gianmarco Giretti on 15.10.18.
//  Copyright © 2018 Gianmarco Giretti. All rights reserved.
//

import UIKit
import CoreData
// CoreData muss Importiert werden, da wir eine Datenbank anbindung verwenden

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {
    //UIViewController ist für die Verwaltung des Screens der App zuständig. Er managt die Hierarchie von UIViews
    
    //UITextFieldDelegate stellt Methoden zur Verfügung welche das bearbeiten von Text in Textfeldern ermöglicht (UITextField ist für den User Input zuständig und stammt von diesem Interface ab)
   
    //UITableViewDataSource versorgt das TableView Objekt mit den Informationen die es benötigt um die TableView zu bauen und zu verändern. Bsp. Wenn ein fixer return wert kommt bei der anzahl der Sections (unterste beiden Funktionen)
    
    @IBOutlet weak var tableView: UITableView!
    
    var itemName: [NSManagedObject] = []
    //Das NSManagedObjectModel lädt und repräsentiert das im xcdatamodel definierte Datenmodell zur Laufzeit.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Wird aufgerufen kurz bevor der User den Display sieht. Es wird verwendet wenn die View immer neu laden muss, bevor du die View siehst. Ideal für eine ToDo Liste in welcher die Daten für den ViewController geupdated werden müssen. Wenn man diese Funktion überschreibt, muss man jedoch auch eine super Funktion dazu schreiben.

        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //Es wird eine Instanz von AppDelegeate erstellt damit die Verbinfung zwischen der App und der User ermöglicht wird
        
        let context = appDelegate.persistentContainer.viewContext
         //Der persistentContainer speichert die Daten (in die DB) sofern es möglich ist
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Title")
        //Ist für das abrufen des Datenbankinhaltes von der Entity "Title" zuständig
        
        do
        {
           itemName = try context.fetch(fetchRequest)
            //Wird ausgeführt wenn es geklappt hat
        }
        catch
        {
            print("Error in loeaing data")
            //Fehlermeldung
        }
        
        self.tableView.reloadData()
        //Lädt die Seite neu, nachdem sie neugeladen ist
    }
    
    
    
    
    var titleTextField: UITextField!
    //Die Variable welche für die Eingabe vom User zuständig ist
    
    func titleTextField(textField: UITextField!){
        //In dieser Funktion befindet sich das Pop-up Fenster Textfeld in welches wir dann unseren Text einfügen.             Die Variable für die Eingabe des Textes verknüpfen wir damit mit der Methode
        
        titleTextField = textField
        titleTextField.placeholder = "Item Name"
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        //Die Verknüpfung zwischen der Main und dem ViewController.
        
        let alert = UIAlertController(title: "Add your item", message: "Add your item Name below", preferredStyle: .alert)
        //Das Pop-up Alert/Fenster welchem wir einen Titel und eine Message mitgeben. Außerdem geben wir ihm unseren Bevorzugten Style Typ mit, nämlich dem alert.
        
        let addAction = UIAlertAction(title: "Save", style: .default, handler: self.save)
        //Diese Konstante ist der Button für das hinzufügen des Items. Wir nennen ihn "Save". Wenn man man eine Self Referenz hier anlegt,macht man als Style ein .default.                                                    Mit dem Schlüsselwort self wird auf Eigenschaften und Methoden der Klasse zugegriffen (kann entfallen, sofern keine gleichnamige lokale Variable definiert ist). Hier ist in dem Fall die Methode safe gemeint.   Der Handler führt etwas aus / leitet etwas weiter wenn der Button gedrückt wurde
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //Das selbe wie oben
        
        alert.addAction(addAction)
        //Der Button für das hinzufügen
        
        alert.addAction(cancelAction)
        //Der Button für das ablehnen
        
        alert.addTextField(configurationHandler: titleTextField)
        //configurationHandler- fügt ein Textfeld zum Alert hinzu
        
        self.present(alert, animated: true, completion: nil)
        //present ist für die Animation zuständig. Ohne Present taucht kein Pop-up Fenster auf
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Das ist die Funktion, die es ermöglicht den Zellen Inhalt zu löschen
        if editingStyle == UITableViewCell.EditingStyle.delete {
            //Diese if-Anweisung ist dafür da,dass der Zelleninhalt wirklich gelöscht wird
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //Ermöglicht die Verbinfung zwischen der App und der User Interaktion
            
            let context = appDelegate.persistentContainer.viewContext
            //Der persistentContainer speichert die Daten (in die DB) sofern es möglich ist
            
            context.delete(itemName[indexPath.row])
            itemName.remove(at: indexPath.row)
            //Hier wird der Inhalt entfernt und gelöscht
            
            do
            {
                try context.save()
                //Es wird versucht den context zu speichern. Wird ausgeführt wenn das löschen erfolgreich war
            }
            catch
            {
                print("There was a Error in deleting.")
                //Steht in der Konsole, wenn das löschen fehlerhaft war
            }
            self.tableView.reloadData()
            //Die View wird neu geladen,damit mann dann die View ohne den geläschten Inhalt sieht.
        }
    }
    
    func save(alert: UIAlertAction!) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //Ermöglicht die Verbinfung zwischen der App und der User Interaktio
        
        let context = appDelegate.persistentContainer.viewContext
        //Der persistentContainer speichert die Daten (in die DB) sofern es möglich ist
        
        let entity = NSEntityDescription.entity(forEntityName: "Title", in: context)!
        //Hier wird auf die Datenbank/Entity verwiesen
        
        let theTitle = NSManagedObject(entity: entity, insertInto: context)
        //Hier wird die Konstante des Attributes hinzugefügt
        
        theTitle.setValue(titleTextField.text, forKey: "title")
        //Hier wird der Wert dem Attribut hinzugefügt
        
        do
        {
            try context.save()
            itemName.append(theTitle)
            //Die Konstante wird versucht gespeichert zu werden
        }
        
        catch
        {
            print("There was a Error in saving")
        }
        self.tableView.reloadData()
        //Seite wird neu geladen
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemName.count
        //Es wird die Anzahl der Reihen returned, dass heißt angezeugt werden
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let title = itemName[indexPath.row]
        //title ist die Konstante mit der länge der Anzahl der der Items
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Das "dequeueReusableCell" Objekt nimmt eine Zelle von deinem Storyboard und erlaubt es dir es zu benützen wenn du es aufrufst. Richtet den Text in der tableViewCell ein.
        
        cell.textLabel?.text = title.value(forKey: "title") as? String
        //Hier wird, falls es eine Texteinageb wird der Text bei den Attributen gespeichert (In der Regel ein String, optional auch eine Alternative)
        
        return cell
        //gibt die Zelle zurück um die es sich handelt
        
    }
        
        
}

