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
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var goalTextField: UITextField!
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        goalTextField.delegate = self
        
        
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

            }
            self.dismiss(animated: true)
//             defer はブロックを抜ける時に defer 内の処理が実行されます
//              defer {
//                 picker.dismiss(animated: true, completion: nil)
//              }

//              // 選択した画像から PHAsset を取得
//              // 画像ライブラリへのアクセスが許可されていない場合は nil が返ってきます
//              guard let phAsset = info[.phAsset] as? PHAsset else { return }
//
//              let options = PHContentEditingInputRequestOptions()
//            phAsset.requestContentEditingInput(with: options) { [self] (input, info) in
//                  // fullSizeImageURL に選択した画像のURLが入っているのでアンラップします
//                  guard let url = input?.fullSizeImageURL else { return }
//
//                  // これを Realm に保存するなりしてください
//                  // Realm だと URL は保存できないと思うので、Stringに変換するといいかもしれないです
//                  print(url.absoluteString)
//                  let image = url.absoluteString
//                  let user = User()
//                  user.icon = image
//
//                  try! self.realm.write {
//                      realm.add(user)
//                  }
//              }
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


