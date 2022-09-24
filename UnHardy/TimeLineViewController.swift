//
//  TimeLineViewController.swift
//  UnHardy
//
//  Created by ryo on 2022/09/17.
//

import UIKit
import RealmSwift

class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let realm = try! Realm()
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addData = realm.objects(Add.self)
        print("全てのデータ\(addData)")
        
        table.dataSource = self
        table.delegate = self
   
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        table.reloadData()
    }
    
//    @IBAction func photo() {
//        MainTabBarController().didTapPlus()
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let addData = realm.objects(Add.self)
        return addData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 400
     }
    
    @IBAction func share() {
        //シェアするテキストを作成
        let text = "〇〇日継続🔥"
        let hashTag = "#目標"
        let advTag = "#UnHardy"
        let completedText = text + "\n" + hashTag + "\n" + advTag

        //作成したテキストをエンコード
        let encodedText = completedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        //エンコードしたテキストをURLに繋げ、URLを開いてツイート画面を表示させる
        if let encodedText = encodedText,
            let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
            UIApplication.shared.open(url)
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
