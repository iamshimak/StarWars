//
//  PlanetInfoTableViewCell.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2022-05-26.
//

import UIKit

class PlanetInfoTableViewCell: UITableViewCell, ReusableView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        subtitleLabel.text = nil
        planetImageView.image = nil
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: PlanetViewModel) {
        titleLabel.text = viewModel.planetName
        subtitleLabel.text = viewModel.climate
        planetImageView.load(from: viewModel.imageUrl)
    }
}
