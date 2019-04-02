//
//  ViewController.swift
//  NASA Pictures
//
//  Created by Denis Bystruev on 29/03/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    var photoInfo: PhotoInfo? {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.shared.fetchPhotoInfo { self.photoInfo = $0 }
    }
    
    func updateUI() {
        Networking.shared.fetchImage(url: photoInfo?.url) { image in
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
        
        DispatchQueue.main.async {
            self.titleLabel.text = self.photoInfo?.title
            self.descriptionLabel.text = self.photoInfo?.description
            self.copyrightLabel.text = self.photoInfo?.copyright
        }
    }
}
