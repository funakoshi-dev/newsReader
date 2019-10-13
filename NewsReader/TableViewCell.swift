//
//  TableViewCell.swift
//  NewsReader
//
//  Created by Taku Funakoshi on 2019/10/11.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import OpenGraph

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView:
        UIImageView!
    
    @IBOutlet weak var titleLabel:
        UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // linkプロパティがセットされたときにOGP画像を取得
    var link: String! {
        didSet {
            // URLのOGP情報取得
            OpenGraph.fetch(url: URL(string: link)!) { og, error in
                // OGP情報から取得した画像URLを取得
                let imageUrl = URL(string:(og?[.image])!)
                self.setThumbnailWithFadeInAnimation(imageUrl: imageUrl!)
            }
        }
    }
    // 非同期で画像を取得
    func setThumbnailWithFadeInAnimation(imageUrl: URL!){
        self.thumbnailImageView.sd_setImage(with: imageUrl as URL?, completed: {
            (image, error, cacheType, url) ->Void in
            self.thumbnailImageView.alpha = 0
            UIView.animate(withDuration: 0.25,animations: {self.thumbnailImageView.alpha = 1
            })
        })
    }
    
    
    
}
