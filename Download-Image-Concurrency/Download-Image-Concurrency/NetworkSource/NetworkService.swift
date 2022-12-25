//
//  NetworkService.swift
//  Download-Image-Concurrency
//
//  Created by didin amarudin on 25/12/22.
//

import Foundation

class NetworkService {
    let apiKey = "2174d146bb9c0eab47529b2e77d6b526"
    let language = "en-US"
    let page = "1"
    
    
    func getMovies() async throws -> [Movie] {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/popular")!
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "page", value: page)
        ]
        
        let request = URLRequest(url: components.url!)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200  else {
            fatalError("Error: Can't fetching data.")
        }
        
        let decoder = JSONDecoder()
        let results = try decoder.decode(MovieResponses.self, from: data)
        return movieMapper(input: results.movies)
    }
    
}


extension NetworkService {
    fileprivate func movieMapper(
        input movieResponses: [MovieResponse]
    ) -> [Movie] {
        return movieResponses.map { result in
            return Movie(
                title: result.title,
                posterPath: result.posterPath,
                genres: result.genres,
                voteAverage: result.voteAverage,
                overview: result.overview,
                releaseDate: result.releaseDate,
                popularity: result.popularity
            )
        }
    }
}
