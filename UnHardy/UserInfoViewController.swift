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
        
        let imageUrl = image?.pngData()
        
        do {
            try imageUrl!.write(to: documentDirectoryFileURL)
            user.icon = documentDirectoryFileURL.absoluteString

        } catch {
            //エラー処理
            print("エラー")
        }
        
        
        
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
            
            createLocalDataFile()
            image = selectedImage
        }
        self.dismiss(animated: true)
    }
    
    //保存するためのパスを作成する
        func createLocalDataFile() {
            // 作成するテキストファイルの名前
            let fileName = "\(NSUUID().uuidString).png"

            // DocumentディレクトリのfileURLを取得
            if documentDirectoryFileURL != nil {
                // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
                let path = documentDirectoryFileURL.appendingPathComponent(fileName)
                documentDirectoryFileURL = path
                print(documentDirectoryFileURL)
            }
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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


