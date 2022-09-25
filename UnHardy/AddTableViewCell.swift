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
    
}
