//
//  NYTViewModal.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import UIKit

class ArticleListViewModal: NSObject {
     private var modal: MostViewed? {
        didSet {
            if let safeModal = modal {
                prepareDataForView(modal: safeModal)
                didFetchArticles?()
            }
            
        }
    }
    var articleCount = 0
    var tableDataSource: [(title: String,
        author: String,
        detailImageURL: String,
        thumbNailImage: String,
        detailText: String,
        publishedDate: String)] = []
    var didFetchArticles: (() -> Void)?
    var failFetchArticles: ((_ message:String) -> Void)?
    private let serviceManager: WebserviceManager
    init(manager: WebserviceManager) {
        self.serviceManager = manager
    }
    func loadArticles() {
        serviceManager.loadMostViewedArcticles(period: 1) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                self.modal = data
            case .failure(let error):
                self.failFetchArticles?(error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
    func prepareDataForView(modal: MostViewed) {
    tableDataSource.removeAll()
        articleCount = modal.results.count
        for result in modal.results {
            let detailMedia = result.media.first?.mediaMetadata.last?.url ?? ""
            let thumbnailMedia = result.media.first?.mediaMetadata.first?.url ?? ""
            tableDataSource.append((result.title,
                                    author: result.byline,
                                    detailImageURL: detailMedia,
                                    thumbNailImage: thumbnailMedia,
                                    detailText: result.abstract,
                                    publishedDate: result.publishedDate))
        }
    }
}
