//
//  UIImageView+URL.swift
//  Testagram
//
//  Created by Ramazan Rustamov on 07.01.23.
//

import UIKit

extension UIImageView {
    func load(url: String) {
        DispatchQueue.global().async { [weak self] in
            guard let link = URL(string: url) else {return}
            if let data = try? Data(contentsOf: link) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
