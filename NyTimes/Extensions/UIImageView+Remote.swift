//
//  UIImageView+Remote.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import UIKit

extension UIImageView {
   static let cache = NSCache<NSString, UIImage>()

    public func image(fromURL: String) {
        if let cachedImage = UIImageView.cache.object(forKey: fromURL as NSString) {
                self.image = cachedImage
                return
        }

        guard let url = URL(string: fromURL) else {
            print("Could not create url for imageview")
            self.image = UIImage(named: "notAvailable")
            return
        }
        print(fromURL)
        let imageTask = URLSession.shared.dataTask(with: url) { (data, _, error) in            if let error = error {
                DispatchQueue.main.async {
                self.image = UIImage(named: "notAvailable")
                }
                print("Error in downloading image for imageview\(error)")
            }
            if let imageData = data {
                UIImageView.cache.setObject(UIImage(data: imageData)!, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
        imageTask.resume()
    }
}
