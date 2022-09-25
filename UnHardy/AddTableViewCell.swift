//
//  AddTableViewCell.swift
//  UnHardy
//
//  Created by ryo on 2022/09/25.
//

import UIKit
import RealmSwift

class AddTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLineImage: UIImageView!
    @IBOutlet weak var testLabel: UILabel!
    
    let realm = try! Realm()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(timeLine: UIImage) {
        
        timeLineImage.image = timeLine
        
        let addData = realm.objects(Add.self)
        
        for i in 0...addData.count {
            let fileURL = URL(string: addData[i].image)
            //パス型に変換
            let filePath = fileURL?.path

            timeLineImage.image = UIImage(contentsOfFile: filePath!)
        }
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
    
}
