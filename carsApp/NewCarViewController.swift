//
//  NewCarViewController.swift
//  carsApp
//
//  Created by Slava Kuzmitsky on 25.02.2020.
//  Copyright © 2020 Slava Kuzmitsky. All rights reserved.
//

import UIKit
import Cosmos

class NewCarViewController: UITableViewController {
    
    var imageIsChanged = false
    var currentRaiting = 0.0
    var detailCar:  Car?
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carBrand: UITextField!
    @IBOutlet weak var carModel: UITextField!
    @IBOutlet weak var carYear: UITextField!
    @IBOutlet weak var carPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        carBrand.addTarget (self, action: #selector(textFieldChanged), for: .editingChanged)
        setuoEditScreen()
        cosmosView.didTouchCosmos = {raiting in
            self.currentRaiting = raiting
            
        }
    }
    
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func saveCar () {
        
        var image: UIImage?
        
        if imageIsChanged {
            image = carImage.image
        } else {
            image = #imageLiteral(resourceName: "car-png-download-.png")
        }
        
        let imageData = image?.pngData()
        
        let newCar = Car(brand: carBrand.text!, model: carModel.text!, year: Int(carYear.text!)!, price: Int(carPrice.text!)!, imageData: imageData, raiting: currentRaiting)
        if detailCar != nil {
            try! realm.write{
                detailCar?.imageData = newCar.imageData
                detailCar?.brand = newCar.brand
                detailCar?.model = newCar.model
                detailCar?.year = newCar.year
                detailCar?.price = newCar.price
                detailCar?.raiting = newCar.raiting
            }
        }
        else{
            StorageManager.saveObject(newCar)
        }
    }
    
    private func setuoEditScreen(){
        if detailCar != nil {
            setupNavigationBar()
            guard  let data = detailCar?.imageData, let image = UIImage(data: data) else {return}
            carImage.image = image
            carImage.contentMode = .scaleAspectFill
            
            carBrand.text =  detailCar?.brand
            carModel.text = detailCar?.model
            carYear.text = String(detailCar!.year)
            carPrice.text = String(detailCar!.price)
            cosmosView.rating = detailCar!.raiting
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem (title: "", style: .plain, target: nil, action: nil )
        }
        navigationItem.leftBarButtonItem = nil
        title = "\(detailCar!.brand) - \(detailCar!.model)"
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

// MARK: Text field delegate
extension NewCarViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        
        if carBrand.text?.isEmpty == false  {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

//MARK: Work with image
extension NewCarViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        carImage.image = info[.editedImage] as? UIImage
        carImage.contentMode = .scaleAspectFill
        carImage.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
}
