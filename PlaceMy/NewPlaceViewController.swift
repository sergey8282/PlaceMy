//
//  NewPlaceViewController.swift
//  PlaceMy
//
//  Created by СОВА on 09.01.2021.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    

    
    // Вспомагательное свойство для добавления фото по умалчанию когда пользователь не указал фото
    var imageIsChanget = false
    
    
    // Кнопка сохранения
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Оутлет изображения
    @IBOutlet weak var placeImage: UIImageView!
    
    // Текстфилд Названия
    @IBOutlet weak var plaseName: UITextField!
    
    // Текстфилд адреса
    @IBOutlet weak var plaseLocation: UITextField!
    
    // Тексфилд описания
    @IBOutlet weak var plaseType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // убирает линии ниже нужных в таблице
        tableView.tableFooterView = UIView()
        
        // скрывает кнопку Cave
        saveButton.isEnabled = false
        
        // метод условия для появления кнопки Cave
        plaseName.addTarget(self, action: #selector(textFildChanget), for: .editingChanged)

    }
    
    // MARK: - Table View delegate
    
    // Условие при нажатии первой ячейки вызывается меню на остальные скрывается клавиатура
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // если нажата первая строчка в таблице то появляется меню
        if indexPath.row == 0 {
            
            
            // иконки для кнопки выбора
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            
            
            // Создает контроллер меню
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            
            // Экшен выбор камеры в меню добовления
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            // добовляет иконку к кнопке
            camera.setValue(cameraIcon, forKey: "image")
            // прижимает текст к левой границе
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            // Экшен выбор фото из галлереи при выборе в меню
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            // добовляет иконку к кнопке
            photo.setValue(photoIcon, forKey: "image")
            // прижимает текст к левой границе
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            // Выход из меню добовления
            let cansel = UIAlertAction(title: "Cansel", style: .cancel)
            
            // Присвоение контроллеру значений кнопок
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cansel)
            
            // Запускает меню и кнопки на экране при нажании первой ячейки
            present(actionSheet, animated: true)
            
        } else {
            // Если нажаты остальные строчки кроме первой то клавиатура сворачивается
            view.endEditing(true)
        }
    }
    
    // метод для добавления нового заведения и трансляции новых значений
    func saveNewPlace() {
        
        // создаем переменную для записи изображения
        var image: UIImage?
        
        // Если есть фото то присваивается если нет то по умолчанию
        if imageIsChanget {
            image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        
        // переводим тип данных из UIImage в Data потдерживаемый базой данных
        let imageData = image?.pngData()
        
        // конструктор полей передоваемых значений в классе
        let newPlace = Place(name: plaseName.text!, location: plaseLocation.text, type: plaseType.text, imageData: imageData)
        
        // записываем данные в базу данных
        StorageManager.saveObject(newPlace)
    }

    
    // Кнопка назад с методом возврата и удалении из памяти
    @IBAction func canselAction(_ sender: Any) {
        
        // возврат и удалении из памяти
        dismiss(animated: true)
    }
    

}

// MARK: - Text fild delegate

extension NewPlaceViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Условие при котором кнопка Cave показывается
    @objc private func textFildChanget() {
        
        // Если текстфилд названия заполнен то кнопка показывается
        if plaseName.text?.isEmpty == false{
            saveButton.isEnabled = true
            // Если не заполнено то не показывается
        } else {
            saveButton.isEnabled = false
        }
    }
}

// MARK: Work with image

// Расширение класса для добовления и изменения изображения
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // Метод для выбора в меню фото или камеры для загрузки изображения
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        // Проверка на доступность источника картинки
        if UIImagePickerController.isSourceTypeAvailable(source) {
            
            //создаем имеге пикер контроллел
            let imagePicker = UIImagePickerController()
            
            // делегирует в другой метод imagePickerController
            imagePicker.delegate = self
            
            // позволяет отредактировать изображение
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            
            // отображает его на экране
            present(imagePicker, animated: true)
        }
    }
    
    // этот метот присваиват выбранное изображение
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // метод дает возможность работать над редактированием изображения
        placeImage.image = info[.editedImage] as? UIImage
        
        // определяем моштаб
        placeImage.contentMode = .scaleAspectFill
        
        // обрезка по границе
        placeImage.clipsToBounds = true
        
        // отключает фото по умолчанию
        imageIsChanget = true
        
        // закрытие метода
        dismiss(animated: true)
    }
}
