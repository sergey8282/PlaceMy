//
//  MainViewController.swift
//  PlaceMy
//
//  Created by СОВА on 08.01.2021.
//

import UIKit

class MainViewController: UITableViewController {
    

    
    let places = Place.getPlaces()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // MARK: - Table view data source

    // количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    // Передает информацию в строку
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        
        // передает текст с массива в строку по его индексу
        cell.nameLabel.text = places[indexPath.row].name
        
        // передает текс с масива в лейбел локации
        cell.locationLabel.text = places[indexPath.row].location
        
        // передает текс с масива в typeLabel
        cell.typeLabel.text = places[indexPath.row].type
        
        // передает фото в строку по индексу массива
        cell.imageOfPlace.image = UIImage(named: places[indexPath.row].image)
        
        // скругление иконок в строке таблицы по ширене ячейки
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true
        
        
        // обязателььное возвращения информации строки
        return cell
    }
    
    // MARK: - Table view dilegate
    
    
    // Высота ячейки таблицы
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {
        
    }

}
