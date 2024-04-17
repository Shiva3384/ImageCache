//
//  ImageGridView.swift
//  ImageCache
//
//  Created by Siva on 16/04/24.
//

import SwiftUI

struct ImageGridView: View {
    @StateObject private var vm = ImageGridViewModel()
    var columns : [GridItem] = [GridItem(),GridItem(),GridItem()]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach (vm.mediaCoverages) { coverage in
                            AsyncImageView(urlString: getImageURL(thumbnail: coverage.thumbnail),key:coverage.thumbnail.id)
                        }
                    }
                }
                .padding([.leading,.trailing],10)
                .navigationTitle("Image GridView")
            }
            .onAppear {
                DispatchQueue.global(qos: .background).async {
                    vm.dataService.getData(requestURL: vm.coverageURL)
                }
            }
        }
    }
    
    private func getImageURL(thumbnail: Thumbnail) -> String {
        return thumbnail.domain + "/" + thumbnail.basePath + "/40/" + thumbnail.key
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGridView()
    }
}
