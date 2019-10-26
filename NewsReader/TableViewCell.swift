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
import SkeletonView

class TableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
//      サムネイルをスケルトンで表示
        thumbnailImageView.showAnimatedGradientSkeleton()
//      2秒後スケルトン解除。
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            self.thumbnailImageView.hideSkeleton()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // linkプロパティがセットされたときにOGP画像を取得
    var link: String! {
        didSet {
            // URLのOGP情報取得
            OpenGraph.fetch(url: URL(string: link)!) { result in
                switch result {
                    case .success(let og):
                        if let fetchUrl = og[.image] {
                            let imageUrl = URL(string:(fetchUrl))
                            self.setThumbnailWithFadeInAnimation(imageUrl: imageUrl)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                }
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
