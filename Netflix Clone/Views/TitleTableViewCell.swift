//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Aleksa Stojiljkovic on 21.3.22..
//

import UIKit

//ovo je nas cell custom cell koj ce korisitimo za upcoming
class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        var image = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
//        image = image?.withRenderingMode(.alwaysOriginal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        
        return label
    }()
    
    private let titlePosterUIImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlePosterUIImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints(){
        
        let titlePosterUIImageConstraints = [
            titlePosterUIImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlePosterUIImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titlePosterUIImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImage.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor, constant: 25)
        ]
        
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ]
        
        
        NSLayoutConstraint.activate(titlePosterUIImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playTitleButtonConstraints)

    }
    
    public func configure(with model: TitleViewModel){
//        guard let url = URL(string: model.posterURL) else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)")else {
            return
        }
        
        titlePosterUIImage.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
}
