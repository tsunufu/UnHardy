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
    // userdefaultsを用意しておく
    let UD = UserDefaults.standard

    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var goalText: UILabel!
    @IBOutlet var keizokuText: UILabel!
    @IBOutlet var obakeText: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = UNMutableNotificationContent()
        content.title = "ここに通知のタイトル"
        content.body = "ここに通知の本文"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //日付表示テスト
        let dt = Date()
        let dateFormatter = DateFormatter()

        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))

        print(dateFormatter.string(from: dt))
        
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
    
    //日付判定関数
    func judgeDate(){
        //現在のカレンダ情報を設定
        let calender = Calendar.current
        //日本時間を設定
        let now_day = Date(timeIntervalSinceNow: 60 * 60 * 9)
        //日付判定結果
        var judge = Bool()

        // 日時経過チェック
        if UD.object(forKey: "today") != nil {
             let past_day = UD.object(forKey: "today") as! Date
             let now = calender.component(.day, from: now_day)
             let past = calender.component(.day, from: past_day)

             //日にちが変わっていた場合
             if now != past {
                judge = true
             }
             else {
                judge = false
             }
         }
         //初回実行のみelse
         else {
             judge = true
             /* 今の日時を保存 */
             UD.set(now_day, forKey: "today")
         }

         /* 日付が変わった場合はtrueの処理 */
         if judge == true {
              judge = false
             //日付が変わった場合の処理をここに書く
         }
         else {
          //日付が変わっていない時の処理をここに書く
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
