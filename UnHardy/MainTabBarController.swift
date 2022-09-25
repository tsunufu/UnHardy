//
//  MainTabBarController.swift
//  UnHardy
//
//  Created by ryo on 2022/09/17.
//

import UIKit
import RealmSwift
import Photos

class MainTabBarController: UITabBarController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var postImage: UIImageView!
    var image: UIImage?
    var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        //タブバーのアイコンの色
        UITabBar.appearance().tintColor = UIColor.black
        //タブバーの背景色
        //        UITabBar.appearance().barTintColor = UIColor.red
        let appearance = UITabBarAppearance()
        appearance.backgroundColor =  UIColor(red: 225/255, green: 216/255, blue: 208/255, alpha: 1.0)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        //        let appearanceNav = UINavigationBarAppearance()
        //        appearanceNav.configureWithOpaqueBackground()
        //        // NavigationBarの背景色の設定
        //        appearanceNav.backgroundColor = UIColor.red
        //アイコンに画像セット
        let plusBarButtonItem = UIBarButtonItem(image: UIImage(named: "Plus")!, style: .plain, target: self, action: #selector(didTapPlus))
        navigationItem.rightBarButtonItem = plusBarButtonItem
        //アイコンの色変更
        plusBarButtonItem.tintColor = UIColor.black
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ナビゲーションバー再表示
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    //プラスボタン押された時
    @objc func didTapPlus() {
        //カメラが使えるかのかくにん
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            //カメラを起動
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        } else {
            //使えない場合はコンソールにエラーを出力
            print("error")
        }
    }
    
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        dismiss(animated: true, completion: nil)

        let add = Add()

        let fileName = "\(NSUUID().uuidString).png"
        add.image = getFileName(exten: fileName)


        let imageUrl = image?.pngData()

        do {
            //            try imageUrl!.write(to: documentDirectoryFileURL)
            let fileName = "\(NSUUID().uuidString).png"
            add.image = getFileName(exten: fileName)
            //add.image = documentDirectoryFileURL.absoluteString

        } catch {
            //エラー処理
            print("エラー")
        }


        try! realm.write {
            realm.add(add)
        }

    }

//    // 画像を保存するメソッド
//    func saveImage(image: UIImage) -> String? {
//        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }
//        
//        do {
//            let fileName = UUID().uuidString + ".jpeg" // ファイル名を決定(UUIDは、ユニークなID)
//            let imageURL = getImageURL(fileName: fileName) // 保存先のURLをゲット
//            try imageData.write(to: imageURL) // imageURLに画像を書き込む
//            return fileName
//        } catch {
//            print("Failed to save the image:", error)
//            return nil
//        }
//    }
//    
//    // URLを取得するメソッド
//    func getImageURL(fileName: String) -> URL {
//        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        return docDir.appendingPathComponent(fileName)
//    }
    
    
    func getFileName(exten: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: Date()) + exten
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
