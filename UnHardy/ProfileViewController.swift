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
    @IBOutlet var obakeText: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userData = realm.objects(User.self)
        let addData = realm.objects(Add.self)
        print("全てのデータ\(userData)")
        //URL型にキャスト(ここは不要そう)
        let fileURL = URL(string: userData[0].icon)
        getFileInDocumentsDirectory(fileName: userData[0].icon)
        //パス型に変換(ここは不要そう)
        let filePath = fileURL?.path
        
        userName.text = userData[0].name
        goalText.text = userData[0].goal
        keizokuText.text = "\(addData.count)日継続中！"
        userImage.image = UIImage(contentsOfFile: getFileInDocumentsDirectory(fileName: userData[0].icon))
        userImage.contentMode = UIView.ContentMode.scaleAspectFill
        userImage.circle()
        obakeText.text = "\(addData.count + 1)日目も頑張ろう！"
        

        // Do any additional setup after loading the view.
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as NSURL
        return documentsURL
    }
    
    //保存してあるurlからpathを毎回生成する
    func getFileInDocumentsDirectory(fileName: String) -> String {
        
        let fileURL = getDocumentsURL().appendingPathComponent(fileName)
        return fileURL!.path
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
