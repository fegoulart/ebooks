//
//  UIImageView+Extensions.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import Kingfisher

extension UIImageView {
    func download(image downloadUrl: String) {
        guard let imageURL = URL(string: downloadUrl) else {
            self.image = UIImage(named: "SquareImage")
            return
        }
        let image = UIImage(named: "SquareImage")
        self.kf.setImage(with: ImageResource(downloadURL: imageURL), placeholder: image)
    }
}
