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
        
        userName.text = userData[0].name
        goalText.text = userData[0].goal

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
