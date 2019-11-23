//
//  DetailViewController.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var lblDetail: UILabel!
    // MARK: - Properties
    private var viewModel: DetailViewModal!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModal()
        configureView()
    }
    var detailItem: (title: String, detail: String, imageURL: String)? {
        didSet {
            configureView()
        }
    }
    func configureView() {
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.title
            }
            if let image = imageArticle {
                image.image(fromURL: detail.imageURL)
            }
            if let detailtextLbl = lblDetail {
                detailtextLbl.text = detail.detail
            }
        }
    }

}
