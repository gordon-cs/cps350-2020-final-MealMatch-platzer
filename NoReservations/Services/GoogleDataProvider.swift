/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import CoreLocation

typealias PlacesCompletion = ([GooglePlace]) -> Void
typealias PhotoCompletion = (UIImage?) -> Void

class GoogleDataProvider {
  private var photosDictionary: [String: UIImage] = [:]
  private var placesTask: URLSessionDataTask?
  private var session: URLSession {
    return URLSession.shared
  }
    
    private var places: [GooglePlace] = []

  func fetchPlaces(
    near coordinate: CLLocationCoordinate2D,
    completion: @escaping PlacesCompletion
  ) -> Void {
    
    if (!self.places.isEmpty) {
        completion(self.places)
    }
    print("Fetch places called with coordinates \(coordinate.description)")
    
    var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate)&rankby=distance&key=\(googleApiKey)&type=restaurant"
    urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
    
    guard let url = URL(string: urlString) else {
        print("fetch places failed to encode URL, returning empty places array")
      completion([])
      return
    }
    
    if let task = placesTask, task.taskIdentifier > 0 && task.state == .running {
      task.cancel()
    }
    
    placesTask = session.dataTask(with: url) { data, response, _ in
      guard let data = data else {
        DispatchQueue.main.async {
            print("Fetch places returned no data, returning empty places array")
          completion([])
        }
        return
      }
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      guard let placesResponse = try? decoder.decode(GooglePlace.Response.self, from: data) else {
        DispatchQueue.main.async {
          completion([])
        }
        return
      }
      
      if let errorMessage = placesResponse.errorMessage {
        print(errorMessage)
      }
      
      DispatchQueue.main.async {
        self.places = placesResponse.results
        completion(placesResponse.results)
      }
    }
    placesTask?.resume()
  }
}
