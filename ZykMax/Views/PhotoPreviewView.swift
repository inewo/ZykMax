import SwiftUI

struct PhotoPreviewView: View {
    let image: UIImage
    var onAnalyze: () -> Void
    var onChooseAnother: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("ZykMax")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                
                // Analyze Button
                Button(action: onAnalyze) {
                    HStack {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(.yellow)
                        Text("Analyze my Zyk")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.purple)
                    )
                }
                .padding(.horizontal)
                
                // Choose Another Photo Button
                Button(action: onChooseAnother) {
                    Text("Choose Different Photo")
                        .foregroundColor(.yellow)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                }
                .padding(.top, 8)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
} 