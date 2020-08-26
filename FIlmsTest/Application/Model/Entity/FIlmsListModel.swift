//
//  FIlmsListModel.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 17.06.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import Foundation


// MARK: - FilmsList

struct FilmsList: Codable {
    let page, totalResults, totalPages: Int
    let results: [Film]
}

// MARK: - Result

struct Film: Codable {
    let id: Int
    let video: Bool?
    let voteCount: Int?
    let voteAverage: Double?
    let title, releaseDate: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview, posterPath: String?
    let popularity: Double?
    let mediaType: String?
}

