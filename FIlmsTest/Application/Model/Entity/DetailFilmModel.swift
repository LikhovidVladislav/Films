//
//  DetailFilmModel.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 17.06.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import Foundation

struct DetailFilm: Decodable {
    let id: Int?
    let title: String?
    let overview: String?
    let genres: [Genre]?
    let posterPath: String?
    let releaseDate: String?

}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int
    let name: String
}

