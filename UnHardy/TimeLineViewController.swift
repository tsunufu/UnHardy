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
    
    var imageNameArray: [String] = []
    
    @IBOutlet var table: UITableView!
    @IBOutlet var timeLineImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addData = realm.objects(Add.self)
        print("全てのデータ\(addData)")
        
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "AddTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let addData = realm.objects(Add.self)
       
//        for i in 0...addData.count - 1{
//            print(addData[i].image)
//            imageNameArray.append(getFileInDocumentsDirectory(fileName: addData[i].image))
//            print(imageNameArray)
//        }

        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AddTableViewCell
        
        let addData = realm.objects(Add.self)
        let add: Add = addData[indexPath.row]

       // let fileURL = URL(string: add.image)
        //getFileInDocumentsDirectory(fileName: add.image)
        //パス型に変換
        //let filePath = fileURL?.path
       // print("pasu", filePath!)
        
   //     cell.timeLineImage.image = UIImage(named: "Clock")
        cell.testLabel.text = getFileInDocumentsDirectory(fileName: add.image)
        cell.timeLineImage.image = UIImage(contentsOfFile: getFileInDocumentsDirectory(fileName: add.image))
 
        print("作成した", getFileInDocumentsDirectory(fileName: add.image))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 400
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
    
    //保存した画像を表示するためのメソッド
    func getFileName(exten: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: Date()) + exten
    }
    
//    @IBAction func share() {
//        //シェアするテキストを作成
//        let text = "〇〇日継続🔥"
//        let hashTag = "#目標"
//        let advTag = "#UnHardy"
//        let completedText = text + "\n" + hashTag + "\n" + advTag
//
//        //作成したテキストをエンコード
//        let encodedText = completedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//
//        //エンコードしたテキストをURLに繋げ、URLを開いてツイート画面を表示させる
//        if let encodedText = encodedText,
//            let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
//            UIApplication.shared.open(url)
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
