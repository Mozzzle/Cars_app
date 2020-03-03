//
//  DetailCarViewController.swift
//  carsApp
//
//  Created by Slava Kuzmitsky on 28.02.2020.
//  Copyright © 2020 Slava Kuzmitsky. All rights reserved.
//

import UIKit


class DetailCarViewController: UITableViewController {
    
    @IBOutlet weak var detailCarImage: UIImageView!
    @IBOutlet weak var detailCarBrand: UITextField!
    @IBOutlet weak var detailCarModel: UITextField!
    @IBOutlet weak var detailCarYear: UITextField!
    @IBOutlet weak var detailCarPrice: UITextField!
    
    var detailCar : Car
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCarImage.image =  detailCar.imageData as? UIImage
        detailCarBrand.text = detailCar.brand
        detailCarModel.text = detailCar.model
        detailCarYear.text = String(detailCar.year)
        detailCarPrice.text = String(detailCar.price)
    }
        @IBAction func changeCar(_ sender: UIButton) {
         
        }
    }



