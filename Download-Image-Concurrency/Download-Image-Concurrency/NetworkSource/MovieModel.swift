//
//  MovieModel.swift
//  Download-Image-Concurrency
//
//  Created by didin amarudin on 22/12/22.
//

import Foundation
import UIKit

enum DownloadState {
    case new, downloaded, failed
}

class Movie {
    let title: String
    let posterPath: URL
    let popularity: Double
    let genres: [Int]
    let voteAverage: Double
    let releaseDate: Date
    let overview: String
    
    var image: UIImage?
    var state: DownloadState = .new
    
    init(title: String, posterPath: URL, genres: [Int], voteAverage: Double, overview: String, releaseDate: Date, popularity: Double)  {
        self.title = title
        self.posterPath = posterPath
        self.genres = genres
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
        self.popularity = popularity
    }
}

struct MovieResponses: Codable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let movies: [MovieResponse]

  enum CodingKeys: String, CodingKey {
    case page
    case totalResults = "total_results"
    case totalPages = "total_pages"
    case movies = "results"
  }
}



struct MovieResponse: Codable {
    let title: String
    let posterPath: URL
    let popularity: Double
    let genres: [Int]
    let voteAverage: Double
    let releaseDate: Date
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case posterPath = "poster_path"
        case title
        case genres = "genre_ids"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // MARK: Menentukan alamat gambar.
        let path = try container.decode(String.self, forKey: .posterPath)
        posterPath = URL(string: "https://image.tmdb.org/t/p/w300/\(path)")!
        
        
        // MARK: Menentukan tanggal rilis.
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        releaseDate = dateFormatter.date(from: dateString)!
        
        title = try container.decode(String.self, forKey: .title)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        overview = try container.decode(String.self, forKey: .overview)
        genres = try container.decode([Int].self, forKey: .genres)
        popularity = try container.decode(Double.self, forKey: .popularity)
    }
}

