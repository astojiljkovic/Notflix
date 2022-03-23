//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Aleksa Stojiljkovic on 20.3.22..
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    //nas licni cell sto je vrlo kul
    static let identifier = "TitleCollectionViewCell"
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    //contentview je za individualni cell, a posto radimo sa custom cellovima u collection view moram oda radimo sa contentview
    override init(frame:CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = bounds
    }
    
    public func configure(with model: String) {
//        guard let url = URL(string: model) else {return}
//        posterImageView.sd_setImage(with: url, completed: nil)
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)")else {
            return
        }
        //samo postavljanje slike preko sd paketa za ovaj url koj smo nakalemili
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
