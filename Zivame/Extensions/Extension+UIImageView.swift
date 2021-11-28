//
//  Extension+UIImageView.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import Foundation
import SDWebImage
import UIKit

extension UIImageView {
    
    func setImage(_ url: URL?) {
        self.sd_setImage(with: url, completed: nil)
    }
    
}
