//
//  MainViewController.swift
//  carsApp
//
//  Created by Slava Kuzmitsky on 25.02.2020.
//  Copyright © 2020 Slava Kuzmitsky. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITableViewController {
    
    @IBOutlet weak var sortButton: UIBarButtonItem!
    var cars: Results<Car>!
    var ascendingSorting = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cars = realm.objects(Car.self)
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let car = cars[indexPath.row]
        let deleteAction = UITableViewRowAction (style: .default , title:  "Delete") { (_, _) in
            StorageManager.deleteObject(car)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction ]
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.isEmpty ? 0 : cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let car = cars[indexPath.row]
        
        cell.carNameLabel.text = car.brand + " - "  + car.model
        cell.yearLabel.text = String(car.year)
        cell.priceLabel.text = "\(String(car.price))$"
        cell.imageOfCar.image = UIImage(data: car.imageData!)
        cell.stars.rating = car.raiting
        cell.imageOfCar.layer.cornerRadius = cell.imageOfCar.frame.size.height / 2
        cell.imageOfCar.clipsToBounds = true
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newCarVC = segue.source as? NewCarViewController else { return }
        
        newCarVC.saveCar ()
        tableView.reloadData()
    }
    
//    @IBAction func  unwindSegue(_ segue:UIStoryboardSegue) {
//        guard let detailCarVC = segue.source as? DetailCarViewController else {return}
//
//    }
//}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let car = cars[indexPath.row]
        let DetailVC = segue.destination as! NewCarViewController
        DetailVC.detailCar = car
        tableView.reloadData()
        }
    }
    @IBAction func sortingPrice(_ sender: Any) {
        cars = cars.sorted(byKeyPath: "price", ascending: ascendingSorting)
        ascendingSorting.toggle()
        if ascendingSorting {
            sortButton.image = #imageLiteral(resourceName: "AZ")
        }
        else {
            sortButton.image = #imageLiteral(resourceName: "ZA")
        }
        tableView.reloadData()
    }
    
}


