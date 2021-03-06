//
//  MainViewController.swift
//  PlaceMy
//
//  Created by СОВА on 08.01.2021.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Отлет таблицы
    @IBOutlet weak var tableView: UITableView!
    
    // Оутлет сегмента для сортировки
    @IBOutlet weak var segmetedControl: UISegmentedControl!
    
    // Название кнопки для реверса сортировки
    @IBOutlet weak var reverstSortingButton: UIBarButtonItem!
    
    

    // масив с заведениями с класса PlaceModel
    var places: Results<Place>!
    
    // Помошник для сортировки
    var ascentigSorting = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
        
    }

    // MARK: - Table view data source

    // количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    // Передает информацию в строку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        // Упрощает конструкцию масива по индексу
        let place = places[indexPath.row]


        // передает текст с массива в строку по его индексу
        cell.nameLabel.text = place.name

        // передает текс с масива в лейбел локации
        cell.locationLabel.text = place.location

        // передает текс с масива в typeLabel
        cell.typeLabel.text = place.type

        // По умалчанию ставит изображение тарелочку
        cell.imageOfPlace.image = UIImage(data: place.imageData!)


        // скругление иконок в строке таблицы по ширене ячейки
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true


        // обязателььное возвращения информации строки
        return cell
    }
    
    // MARK: - Удаление из базы два метода
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            let place = places[indexPath.row]
            // удаление с базы
            StorageManager.deleteObject(place)
            // перезагружается на экране
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let place = places[indexPath.row]
//
//        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, _) in
//            StorageManager.deleteObject(place)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//
//
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//    }
    
    // MARK: - Table view dilegate
    
    
    // Высота ячейки таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    
    

    // MARK: - Navigation

    // редактирование имеющихся заведений
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showDitail" {
            // Определяет выбранную ячейку
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place = places[indexPath.row]
            // создаем параметр выбраной ячейки
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currenPlace = place
        }

    }
    
    // Кнопка Cave при добавлении нового заведения
    @IBAction func anvinSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaseVC = segue.source as? NewPlaceViewController else { return }
        
        // запускает метод в класе NewPlaceViewController
        newPlaseVC.savePlace()
        

        
        // обновляет интерфейс
        tableView.reloadData()
        
        
    }
    
    // Сегмент контрол по дате или имени
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        
        sorting()
        tableView.reloadData()
        
    }
    
    // Реверсия сортировки
    @IBAction func reversSorting(_ sender: Any) {
        
        ascentigSorting.toggle()
        
        if ascentigSorting {
            reverstSortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reverstSortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        sorting()
        tableView.reloadData()
    }
    
    // Метод сортировки по дате и имени
    private func sorting() {
        
        if segmetedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascentigSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascentigSorting)
        }
        
        
    }
}
