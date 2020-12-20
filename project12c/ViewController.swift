//
//  ViewController.swift
//  project12c
//
//  Created by Tigran on 12/18/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "photos") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                photos = try jsonDecoder.decode([Photo].self, from: savedData)
            } catch  {
                print("Faild to load data")
            }
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell else { fatalError("couldn't load cell") }
        cell.accessoryType = .disclosureIndicator

        let photo = photos[indexPath.row]
        cell.cellLabel.text = photo.name

        let path = getDocumentsDirectory().appendingPathComponent(photo.image)
        
        cell.cellImage.image = UIImage(contentsOfFile: path.path)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            let photo = photos[indexPath.row]
            vc.title = photo.name
            
            let path = getDocumentsDirectory().appendingPathComponent(photo.image)
            
            
            vc.path = path.path
            
            navigationController?.pushViewController(vc, animated: true)
        } else { return }
        
    }
    
    @objc func addTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var name = "" {
            didSet {
                photo.name = name
            }
        }
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let photo = Photo(name: name, image: imageName)
        photos.append(photo)
        tableView.reloadData()
        
        dismiss(animated: true) {
            [weak self] in
            let ac = UIAlertController(title: "Name your photo", message: nil, preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "Submit", style: .default){
                [weak ac] action in
                if let text = ac?.textFields?[0].text {
                    name = text
                    self?.save()
                    self?.tableView.reloadData()
                }
                
            })
            self?.present(ac, animated: true)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "photos")
        } else {
            print("Failed to save data")
        }
    }

}

