//
//  AsyncImageView.swift
//  ImageCache
//
//  Created by Siva on 16/04/24.
//

import SwiftUI

struct AsyncImageView: View {
    var urlString: String
    var key: String
    @StateObject var imageLoader = ImageLoader()
    @State var image: UIImage = UIImage()
    @State var progress: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.02)
            if progress {
                ProgressView()
            }
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onReceive(imageLoader.$image) { image in
                    self.image = image
                    progress = false
                }
                .onAppear {
                    progress = true
                    imageLoader.loadImage(for: urlString, key: key)
                }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(urlString: "https://picsum.photos/200",key:"")
    }
}
