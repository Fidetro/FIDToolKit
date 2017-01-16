//
//  HomeListController.swift
//  FIDToolKit
//
//  Created by Fidetro on 2016/12/29.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

import UIKit
import SnapKit

class HomeListController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var homeListPlist = NSArray(contentsOfFile:Bundle.main.path(forResource: "HomeList", ofType: "plist")!);
  lazy  var tableView : UITableView = {
    
         var  tableView = UITableView(frame:CGRect.zero, style:UITableViewStyle.grouped);
        tableView.delegate = self;
        tableView.dataSource = self;
            return tableView;
  }();

    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (homeListPlist?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (homeListPlist![section] as AnyObject).count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");

        if (cell == nil)
        {
//            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell");
            cell = HomeListTableViewCell();
           
        }
         (cell as! HomeListTableViewCell).nicknameLabel.text = ((homeListPlist![indexPath.section]as! Array)[indexPath.row]as AnyObject)["title"] as? String;
        
        
//        (cell as! HomeListTableViewCell).nicknameLabel.text = "asd";
        return cell!;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let QRCodeVC = QRCodeController();
        tableView.deselectRow(at: indexPath, animated: true);
        self.navigationController?.pushViewController(QRCodeVC, animated: true);
        
        
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    

    override func masLayoutSubview() {
          view.addSubview(tableView);
        tableView.snp.remakeConstraints { (make) in
            
            make.edges.equalTo(view);
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

 

}
