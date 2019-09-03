//
//  DetailViewController.swift
//  Home Work 11(12)
//
//  Created by Maksim Grebenozhko on 29/08/2019.
//  Copyright © 2019 Maksim Grebenozhko. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {

    @IBOutlet private var posterImageView: UIImageView!
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var yearLabel: UILabel!
    @IBOutlet private var ratedLabel: UILabel!
    @IBOutlet private var releasedLabel: UILabel!
    @IBOutlet private var runtimeLabel: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var directorLabel: UILabel!
    @IBOutlet private var writerLabel: UILabel!
    @IBOutlet private var actorLabel: UILabel!
    @IBOutlet private var plotLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var countryLabel: UILabel!
    @IBOutlet private var awardsLabel: UILabel!
    @IBOutlet private var metascoreLabel: UILabel!
    @IBOutlet private var imdbRatingLabel: UILabel!
    @IBOutlet private var imdbVotesLabel: UILabel!
    @IBOutlet private var imbdIDLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var dvdLabel: UILabel!
    @IBOutlet private var boxOfficeLabel: UILabel!
    @IBOutlet private var productionLabel: UILabel!
    
    @IBOutlet private var labels: [UILabel]!
    
    @IBOutlet private var websiteButton: UIButton!
    
    @IBOutlet private var detailsScrollView: UIScrollView!
    
    private var details: resultByID!
    
    //MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabels()
        configureButton()
    }
    
    override func viewDidLayoutSubviews() {
        let width = detailsScrollView.contentSize.width
        let height = websiteButton.frame.maxY + 40
        detailsScrollView.contentSize = CGSize(width: width, height: height)
    }
    
    //MARK: - Actions
    
    @IBAction private func didWebsiteOpen() {
        guard let link = websiteButton.titleLabel?.text else { return }
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: - Private methods
    
    private func configureLabels() {
        let fontName = "MarkerFelt-Thin"
        let fontSize = CGFloat(27)
        let font = UIFont(name: fontName, size: fontSize)
    
        for label in labels {
            label.font = font
            label.adjustsFontSizeToFitWidth = true
            if label.tag == 0 {
                label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                label.textColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private func configureButton() {
        websiteButton.titleLabel?.lineBreakMode = .byCharWrapping
        websiteButton.titleLabel?.textAlignment = .center
    }
    
    //MARK: - Networking
    
    func fetchDetailsFor(_ search: String) {
        
        let urlString =
        "https://movie-database-imdb-alternative.p.rapidapi.com/?i=\(search)&r=json"
        guard let url = URL(string: urlString) else { return }
        
        let headers = [
            "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com",
            "x-rapidapi-key": "6976e2adedmsha25ff2200c4f160p14bd1djsn66995eb60a7b"
        ]
        
        request(url,
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: headers).validate().responseJSON { dataResponse in
                    
                    switch dataResponse.result {
                    case .success:
                        let decoder = JSONDecoder()
                        do {
                            if let data = dataResponse.data {
                                self.details = try decoder.decode(resultByID.self, from: data)
                                DispatchQueue.main.async {
                                    self.fillElementsWithData()
                                }
                            }
                        } catch { }
                    case .failure(let error):
                        print(error)
                    }
        }
    }
    
    private func fillElementsWithData() {
        titleLabel.text = details.title
        yearLabel.text = details.year
        ratedLabel.text = details.rated
        releasedLabel.text = details.released
        runtimeLabel.text = details.runtime
        genreLabel.text = details.genre
        directorLabel.text = details.director
        writerLabel.text = details.writer
        actorLabel.text = details.actors
        plotLabel.text = details.plot
        languageLabel.text = details.language
        countryLabel.text = details.country
        awardsLabel.text = details.awards
        metascoreLabel.text = details.metascore
        imdbRatingLabel.text = details.imdbRating
        imdbVotesLabel.text = details.imdbVotes
        imbdIDLabel.text = details.imdbID
        typeLabel.text = details.type
        dvdLabel.text = details.dvd
        boxOfficeLabel.text = details.boxOffice
        productionLabel.text = details.production
        
        websiteButton.setTitle(details.website, for: .normal)
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: self.details.poster!) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }

            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: imageData)
            }
        }
    }

}
