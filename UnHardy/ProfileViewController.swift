//
//  ProfileViewController.swift
//  UnHardy
//
//  Created by ryo on 2022/09/17.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var goalText: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userData = realm.objects(User.self)
        print("全てのデータ\(userData)")
        //URL型にキャスト
        let fileURL = URL(string: userData[24].icon)
        //パス型に変換
        let filePath = fileURL?.path
        
        userName.text = userData[24].name
        goalText.text = userData[24].goal
        userImage.image = UIImage(contentsOfFile: filePath!)
        

        // Do any additional setup after loading the view.
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
