//
//  NewPlaceViewController.swift
//  PlaceMy
//
//  Created by СОВА on 09.01.2021.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // убирает линии ниже нужных в таблице
        tableView.tableFooterView = UIView()

    }
    
    // MARK: - Table View delegate
    
    // Условие при нажатии первой ячейки вызывается меню на остальные скрывается клавиатура
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            // Создает контроллер меню
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // Экшен выбор камеры в меню добовления
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            // Экшен выбор фото из галлереи при выборе в меню
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            // Выход из меню добовления
            let cansel = UIAlertAction(title: "Cansel", style: .cancel)
            
            // Присвоение контроллеру значений кнопок
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cansel)
            
            // Запускает меню и кнопки на экране при нажании первой ячейки
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }



}

// MARK: - Text fild delegate

extension NewPlaceViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Work with image

// Метод для выбора в меню фото или камеры для загрузки изображения
extension NewPlaceViewController {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        // Проверка на доступность источника картинки
        if UIImagePickerController.isSourceTypeAvailable(source) {
            //создаем имеге пикер контроллел
            let imagePicker = UIImagePickerController()
            // позволяет отредактировать изображение
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            // отображает его на экране
            present(imagePicker, animated: true)
        }
    }
}
