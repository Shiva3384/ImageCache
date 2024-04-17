//
//  DataService.swift
//  ImageCache
//
//  Created by Siva on 16/04/24.
//

import Foundation
import Combine


class DataService {
    @Published var mediaCoverages : [MediaCoverage] = []
    var cancellables = Set<AnyCancellable>()
    static let instance = DataService()
    private init() {
        
    }
    
    func getData(requestURL: String) {
        guard let url = URL(string: requestURL) else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap(resonseData)
            .decode(type: [MediaCoverage].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished : do {
                    print("Finished")
                }
                case .failure(let error): do {
                    print("Error :: \(error)")
                }
                }
            } receiveValue: {[weak self] result in
                guard let self = self else {
                    return
                }
                self.mediaCoverages = result
            }
            .store(in: &cancellables)

    }
    
    private func resonseData(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse , response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        
        return output.data
    }
}
