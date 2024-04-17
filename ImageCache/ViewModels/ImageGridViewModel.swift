//
//  ImageGridViewModel.swift
//  ImageCache
//
//  Created by Siva on 16/04/24.
//

import Foundation
import Combine

class ImageGridViewModel: ObservableObject {
    @Published var mediaCoverages: [MediaCoverage] = []
    var cancellables = Set<AnyCancellable>()
    let dataService = DataService.instance
    let coverageURL = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100"
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$mediaCoverages.sink { [weak self] results in
            guard let self = self else {
                return
            }
            self.mediaCoverages = results
        }
        .store(in: &cancellables)
    }
}
