//
//  NewPatternViewController.swift
//  Table View With Sections Storyboard
//
//  Created by Дмитрий Пономарев on 18.11.2022.
//

import UIKit

class NewPatternViewController: UIViewController {
    
    //  MARK: - Properties

    @IBOutlet weak var imageTapped: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    var newPattern: Pattern?
    
    //  MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGesture()
        makeButtonEnable()
        imageTapped.clipsToBounds = true
        imageTapped.isUserInteractionEnabled = true
        saveButton.isEnabled = false
    }
    
    //  MARK: - IBAction

    @IBAction func dimsmissNewPatternController(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func didTapImageView(_ sender: UITapGestureRecognizer) {
        
        let cameraIcon = UIImage(named: "camera")
        let galleryIcon = UIImage(named: "gallery")
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.cameraPicker(source: .camera)
        }
        let library = UIAlertAction(title: "Library", style: .default) {_ in
            self.pickPhoto()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        camera.setValue(cameraIcon, forKey: "image")
        library.setValue(galleryIcon, forKey: "image")
        actionSheet.addAction(camera)
        actionSheet.addAction(cancel)
        actionSheet.addAction(library)
        present(actionSheet, animated: true)
    }
}

//  MARK: - extension chooseImagePicker

extension NewPatternViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func cameraPicker (source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func pickPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
    {
        imageTapped.image = (info[.editedImage] as? UIImage)
        imageTapped.contentMode = .scaleAspectFill
        imageTapped.clipsToBounds = true
        picker.dismiss(animated: true, completion: nil)
    }
}

//  MARK: - extension NewPatternViewController

extension NewPatternViewController {
    
    //  MARK: - setupAction
    
    func addGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappToHideKeyboard)))
    }
    
    //  MARK: - makeButtonEnable

    func makeButtonEnable() {
        nameTF.addTarget(self, action: #selector(enablingBarButtonSave), for: .editingChanged)
        descriptionTF.addTarget(self, action: #selector(enablingBarButtonSave), for: .editingChanged)
    }
    
    func saveNewPattern() {
        newPattern = Pattern(
            title: "Порождающие",
            names: [nameTF.text!],
            description: [descriptionTF.text!],
            image: imageTapped.image)
        
    }
    
    //  MARK: - @objc func
    
    @objc func tappToHideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func enablingBarButtonSave() {
        if nameTF.text?.isEmpty == false && descriptionTF.text?.isEmpty == false {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}

//  MARK: - extension UITextFieldDelegate

extension NewPatternViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
