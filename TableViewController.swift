//
//  TableViewController.swift
//  NewsReader
//
//  Created by Taku Funakoshi on 2019/10/11.
//  Copyright © 2019 Taku Funakoshi. All rights reserved.
//

import UIKit
//Tab描写する用
import XLPagerTabStrip
//iOSのネットワーク通信処理をシンプルにする<->NSURLSession：バックグラウンドでは位置取得や音楽再生等限られた用途しか使用できませんでしたが、iOS7から通信処理にも利用できるようになりました。
import Alamofire
import SwiftyJSON
import SafariServices
import SkeletonView

class TableViewController: UITableViewController,IndicatorInfoProvider {

    var itemInfo = IndicatorInfo(title: "View")
    
    var fetchFrom: String = ""

    // ニュース記事の配列（中身はディクショナリ）
    var articles: [[String: String]] = []

    init(style: UITableView.Style, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    //-------------------------------
    // ニュースフィード取得
    //-------------------------------
    @objc func fetchNewsFeed(){
        Alamofire.request(fetchFrom).responseJSON { response in
            let json = JSON(response.result.value as Any)
            json["articles"].forEach{(_, data) in
                let article: [String: String] = [
                    "title": data["title"].stringValue,
                    "date": data["publishedAt"].stringValue,
                    "link": data["url"].stringValue,
                    "image":data["urlToImage"].stringValue,
                    ]
                self.articles.append(article)
                print("articles:\(self.articles)")
//ニュース記事をTableViewに表示させるためにはニュース記事を取得完了時に表示するよう指示
                self.tableView.reloadData()
                self.refreshControl!.endRefreshing()
            }
        }
    }
    
    
    
    
    
    fileprivate func addRefreshCtl() {
        // 下スワイプで記事再取得・更新　定番の書き方
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "update")
        self.refreshControl?.addTarget(self, action: #selector(TableViewController.fetchNewsFeed), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refreshControl!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNewsFeed()
        // カスタムセル登録
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        addRefreshCtl()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
//TableViewの表示仕様（セクション数、セルの数、セルの中身）を定義していきます。
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // セクションの数を指定
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // セルの数を指定（取得した記事の数）
        return articles.count
    }
    // セル一つ一つの中身を定義
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        // Configure the cell...
        cell.titleLabel.text = articles[indexPath.row]["title"]! // ラベル表示
        cell.thumbnailImageView.image = UIImage() // 描画毎にサムネイルをクリア
        cell.link = articles[indexPath.row]["link"]!
        return cell
    }

    // 一つのセルの高さを指定
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // セルタップ時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = SFSafariViewController(url: URL(string: articles[indexPath.row]["link"]!)!)
        self.present(svc, animated: true, completion: nil)
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
