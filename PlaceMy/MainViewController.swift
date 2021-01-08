//
//  MainViewController.swift
//  PlaceMy
//
//  Created by СОВА on 08.01.2021.
//

import UIKit

class MainViewController: UITableViewController {
    
    let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // MARK: - Table view data source

    // количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    // Передает информацию в строку
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        // передает текст с массива в строку по его индексу
        cell.textLabel?.text = restaurantNames[indexPath.row]
        
        // передает фото в строку по индексу массива
        cell.imageView?.image = UIImage(named: restaurantNames[indexPath.row])
        
        // скругление иконок в строке таблицы по ширене ячейки
        cell.imageView?.layer.cornerRadius = cell.frame.size.height / 2
        cell.imageView?.clipsToBounds = true
        
        
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

}
