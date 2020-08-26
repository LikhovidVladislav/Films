//
//  DetailFIilmViewController.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 17.06.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import UIKit
import Kingfisher

class DetailFilmViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var filmId: Int?
    
    var detailFilmModel: DetailFilm? {
        didSet {
            setupView()
        }
    }
    
    let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let filmId = filmId else { return }
        
        getDetailFilm(id: filmId)
        activityIndicatorView.startAnimating()
    }

    
    private func setupView() {
        guard let detailFilmModel = detailFilmModel else { return }
        
        if let posterPath = detailFilmModel.posterPath {
            posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + posterPath))
        }
        
        titleLabel.text = detailFilmModel.title
        descriptionTextView.text = detailFilmModel.overview
        releasedLabel.text = detailFilmModel.releaseDate
        
        genresLabel.text = getGenres()
        
    }
    
    private func getGenres() -> String {
        guard let genres = detailFilmModel?.genres else { return "" }
        var genresString = ""
        for genre in genres {
            genresString.append(genre.name + " ")
        }
        return genresString
    }
    
    private func getDetailFilm(id: Int) {
        networkManager.getFilmById(id: id) { [weak self] detailFilm, error in
            
            self?.activityIndicatorView.stopAnimating()
            DispatchQueue.main.async {
                if let detailFilm = detailFilm {
                    self?.detailFilmModel = detailFilm
                } else if let error = error {
                    self?.showAlert(alertText: "Error", alertMessage: error.localizedDescription)
                } else {
                    self?.showAlert(alertText: "Error", alertMessage: "Something went wrong. Try again")
                }
            }
        }
    }
}

extension DetailFilmViewController: Storyboardable {
    
    static var storyboardName: String {
        "Main"
    }
}
