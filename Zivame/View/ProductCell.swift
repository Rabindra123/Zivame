//
//  ProductCell.swift
//  Zivame
//
//  Created by Rabi on 28/11/21.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var ratings: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func wrap(_ product: Product) {
        self.imageV.setImage(URL.init(string: product.imageURL ?? ""))
        self.name.text = product.name
        self.price.text = "\(product.price ?? "") ₹"
        let rating = product.rating ?? 0
        self.ratings.text = ""
        for _ in 1...rating {
            self.ratings.text = self.ratings.text?.appending("⭐")
        }
    }
    
}
