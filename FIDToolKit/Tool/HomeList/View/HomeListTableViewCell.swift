

//
//  HomeListTableViewCell.swift
//  FIDToolKit
//
//  Created by Fidetro on 2017/1/16.
//  Copyright © 2017年 Fidetro. All rights reserved.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

   public lazy var nicknameLabel: UILabel = {
        
        var label = UILabel();
        self.addSubview(label);
        label.font = UIFont.systemFont(ofSize: 14);
    
        return label;
    }()
    
        init(){
        
            super.init(style: .default, reuseIdentifier: "6")
            self.accessoryType = .disclosureIndicator;
            masLayoutSubview();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func masLayoutSubview() {
        
        nicknameLabel.snp.remakeConstraints { (make) in
            
            make.left.equalToSuperview().offset(10);
            make.centerY.equalToSuperview();
            
        };
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
