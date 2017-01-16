//
//  BlockCell.swift
//  FIDToolKit
//
//  Created by Fidetro on 2016/12/30.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

import UIKit
import SnapKit
fileprivate extension Selector {
    static let buttonTapped = #selector(BlockCell().changeColor(asd:))

}
class BlockCell: UITableViewCell {
    
    typealias fucBlock = (_ backMsg :String) ->()
 lazy var btn : UIButton! = {
    

    var btn = UIButton();
    self.addSubview(btn);
    btn.backgroundColor = UIColor.red
//    btn.addTarget(self, action:#selector(.changeColor(asd:)), for: .touchUpInside)
    return btn;
        
 }();
    
    init() {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "c")
        
        btn.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview();
        }
  
        
    }
    
    
    func changeColor(asd:UIButton) {
        asd.backgroundColor = UIColor.green
        asd.isSelected = true;
        print("666")
        
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
