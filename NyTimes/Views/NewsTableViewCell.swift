//
//  NewsTableViewCell.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var lblPublisheddate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageUser.backgroundColor = UIColor.darkGray
        imageUser.roundCorners(corners: UIRectCorner.allCorners, radius: 30)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDataNewsCell(title: String,
                         subTitle: String,
                         imagePath: String,
                         publishedDate: String) {
        self.lblTitle.text = title
        self.lblSubTitle.text = subTitle
        self.lblPublisheddate.text = publishedDate
        self.imageUser.image(fromURL: imagePath)
    }
}
