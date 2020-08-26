//
//  NetworkManager.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 26.08.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import Foundation
import Moya

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    private let provider = MoyaProvider<NetworkService>()
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func getFilmsList(completion: @escaping (_ response: FilmsList?, _ error: Error?) -> ()) {
        provider.request(.getListFilms) { result in
            switch result {
            case .success(let response):
                let filmsList = try? self.decoder.decode(FilmsList.self, from: response.data)
                completion(filmsList, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getFilmById(id: Int, completion: @escaping (_ response: DetailFilm?, _ error: Error?) -> ()) {
        provider.request(.getDetailFilmById(id: id)) { result in
            switch result {
            case .success(let response):
                let detailFilm = try? self.decoder.decode(DetailFilm.self, from: response.data)
                completion(detailFilm, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func searchByName(name: String, completion: @escaping (_ response: FilmsList?, _ error: Error?) -> ()) {
        provider.request(.searchByFilmName(name: name)) { result in
            switch result {
            case .success(let response):
                let filmsList = try? self.decoder.decode(FilmsList.self, from: response.data)
                completion(filmsList, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
