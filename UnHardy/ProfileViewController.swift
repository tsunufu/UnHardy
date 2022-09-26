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
    @IBOutlet var keizokuText: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userData = realm.objects(User.self)
        let addData = realm.objects(Add.self)
        print("全てのデータ\(userData)")
        //URL型にキャスト
        let fileURL = URL(string: userData[0].icon)
        //パス型に変換
        let filePath = fileURL?.path
        
        userName.text = userData[0].name
        goalText.text = userData[0].goal
        keizokuText.text = "\(addData.count)日継続中！"
        userImage.image = UIImage(contentsOfFile: filePath!)
        userImage.contentMode = UIView.ContentMode.scaleAspectFill
        userImage.circle()
        

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
