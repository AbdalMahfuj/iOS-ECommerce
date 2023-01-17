//
//  TableViewCell.swift
//  MyEcommerce
//
//  Created by MAHFUJ on 13/1/23.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
        priceLabel.layer.cornerRadius = priceLabel.frame.size.height/5
    }


    func reload(product: Product) {
        titileLabel.text = product.title
        priceLabel.text = String(format: "%.2f", product.price!)
        categoryLabel.text = product.category
        
        if let url = URL(string: product.image!) {
            productImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        
//        if let url = URL(string: product.image!) {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//                DispatchQueue.main.async { [self] in
//                    productImageView.image = UIImage(data: data!)
//                }
//            }//
//        }
        
    }
}
