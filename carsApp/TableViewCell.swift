//
//  TableViewCell.swift
//  carsApp
//
//  Created by Slava Kuzmitsky on 25.02.2020.
//  Copyright © 2020 Slava Kuzmitsky. All rights reserved.
//

import UIKit
import Cosmos

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageOfCar: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stars: CosmosView!
}


