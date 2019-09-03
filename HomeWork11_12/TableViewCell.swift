//
//  TableViewCell.swift
//  Home Work 11. Alamofire
//
//  Created by Maksim Grebenozhko on 28/08/2019.
//  Copyright © 2019 Maksim Grebenozhko. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet private var posterImageView: ImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yearLabel: UILabel!
    @IBOutlet private var imdbLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    
    func configureCellBy(_ result: BySearch) {
        titleLabel.text = result.title
        yearLabel.text = result.year
        imdbLabel.text = result.imdbID
        typeLabel.text = result.type
        
        posterImageView.fetchImage(with: result.poster)
    }
}
