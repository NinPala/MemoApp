//
//  CustomTableViewCell.swift
//  memoApp
//
//  Created by 小松周平 on 2023/03/18.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    public var rightLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization（初期化） code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(style: CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        rightLabel = UILabel()
        rightLabel.frame = CGRect(x:self.frame.width / 2,y:0,width:self.frame.width / 3,height:self.frame.height)
        rightLabel.textAlignment = .left
        

        //セルのアクセサリービューにラベルを設定
        self.accessoryView = rightLabel
    }

}
