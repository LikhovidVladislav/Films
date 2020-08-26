//
//  NetworkService.swift
//  FIlmsTest
//
//  Created by Влад Лиховид on 17.06.2020.
//  Copyright © 2020 Влад Лиховид. All rights reserved.
//

import Moya

enum NetworkService {
    
    case getListFilms
    case getDetailFilmById(id: Int)
    case searchByFilmName(name: String)
    
    var apiKey: String {
        "0423bb8e9599b884f846f1e5cf632cdf"
    }
}

extension NetworkService: TargetType {
    
    var baseURL: URL {
        URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .getListFilms:
            return "/trending/movie/day"
        case .getDetailFilmById(let id):
            return "/movie/\(id)"
        case .searchByFilmName:
            return "/search/movie"
        }
    }
    
    var method: Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .searchByFilmName(let name):
            return .requestParameters(parameters: ["query": name, "api_key": apiKey], encoding: URLEncoding.default)
        case .getListFilms, .getDetailFilmById:
            return  .requestParameters(parameters: ["api_key": apiKey], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}
