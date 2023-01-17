//
//  ProductViewController.swift
//  MyEcommerce
//
//  Created by MAHFUJ on 16/1/23.
//

import UIKit
import SDWebImage

class ProductViewController: UIViewController {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    private var product: Product!

    class func initVC(product: Product)->ProductViewController {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let vc = board.instantiateViewController(withIdentifier: "productViewController") as! ProductViewController
        vc.product = product
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    

    func setUI() { // set all passed elements to this UI
        if let url = URL(string: product.image!) { // set image
            productImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        }
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        categoryLabel.text = "Category: \(product.category!)"
        categoryLabel.textColor = .lightGray
        priceLabel.text = String(format: "%.2f", product.price!)
    }

    
}
