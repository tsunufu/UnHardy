//
//  UserInfoViewController.swift
//  UnHardy
//
//  Created by ryo on 2022/09/17.
//

import UIKit
import SwiftUI
import RealmSwift
import Photos

class UserInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var goalTextField: UITextField!
    
    var image: UIImage?
    var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = "名前"
        goalTextField.placeholder = "目標"
        
        nameTextField.delegate = self
        goalTextField.delegate = self
        
        let userData = realm.objects(User.self)

        if userData.count != 0 {
            self.performSegue(withIdentifier: "toSecond", sender: nil)
        }

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ナビゲーションバー非表示
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }
    
    @IBAction func save() {
        let user = User()
        user.name = self.nameTextField.text!
        user.goal = self.goalTextField.text!
        
//        let imageUrl = image?.pngData()
        
//        do {
//            try imageUrl!.write(to: documentDirectoryFileURL)
//            user.icon = documentDirectoryFileURL.absoluteString
//
//        } catch {
//            //エラー処理
//            print("エラー")
//        }
        
        let tekenPhoto = saveImage(image: image!)
        
        user.icon = tekenPhoto!
        
        try! realm.write {
            realm.add(user)
        }
        
        nameTextField.text = ""
        goalTextField.text = ""
        
        
    }
    
    
    @IBAction func set() {
        //カメラロールを使えるかの確認
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            //カメラロールの画像を選択して画像を表示するまでの一環の流れ
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            
            present(picker, animated: true, completion: nil)
        }
    }
    
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            userImage.image = selectedImage
            userImage.contentMode = UIView.ContentMode.scaleAspectFill
            userImage.circle()
//            createLocalDataFile()
            image = selectedImage
        }
        self.dismiss(animated: true)
    }
    
    //保存するためのパスを作成する
//        func createLocalDataFile() {
//            // 作成するテキストファイルの名前
//            let fileName = "\(NSUUID().uuidString).png"
//
//            // DocumentディレクトリのfileURLを取得
//            if documentDirectoryFileURL != nil {
//                // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
//                let path = documentDirectoryFileURL.appendingPathComponent(fileName)
//                documentDirectoryFileURL = path
//                print(documentDirectoryFileURL)
//            }
//        }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 画像を保存するメソッド
    func saveImage(image: UIImage) -> String? {
      guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }
       
      do {
        let fileName = UUID().uuidString + ".jpeg" // ファイル名を決定(UUIDは、ユニークなID)
        let imageURL = getImageURL(fileName: fileName) // 保存先のURLをゲット
        try imageData.write(to: imageURL) // imageURLに画像を書き込む
        return fileName
      } catch {
        print("Failed to save the image:", error)
        return nil
      }
    }
     
    // URLを取得するメソッド
    func getImageURL(fileName: String) -> URL {
      let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      return docDir.appendingPathComponent(fileName)
    }
    
    
}

extension UIImage {
    func saveToDocuments(filename:String){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        if let data = self.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
            } catch {
                print(error)
            }
        }
    }
    static func getFromDocuments(filename: String) -> UIImage {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let data = try! Data(contentsOf: documentsDirectory.appendingPathComponent(filename))
        let image = UIImage(data: data)
        return image!
    }
}

extension UIImageView {

    func circle() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.width/2
        clipsToBounds = true
    }
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


