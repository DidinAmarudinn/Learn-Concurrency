//
//  ImageDownloader.swift
//  Download-Image-Concurrency
//
//  Created by didin amarudin on 22/12/22.
//

import Foundation
import UIKit

class ImageDownloader {
    func downloadImage(url: URL) async throws -> UIImage {
        async let imageData: Data = try Data(contentsOf: url)
        return UIImage(data: try await imageData)!
    }
}
