import SwiftUI
import PhotosUI

struct HomeView: View {
    let isLoading: Binding<Bool>
    let selectedItem: Binding<PhotosPickerItem?>
    let onImageSelected: (PhotosPickerItem?) -> Void
    
    init(isLoading: Binding<Bool>, selectedItem: Binding<PhotosPickerItem?>, onImageSelected: @escaping (PhotosPickerItem?) -> Void) {
        self.isLoading = isLoading
        self.selectedItem = selectedItem
        self.onImageSelected = onImageSelected
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("ZykMax")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                Spacer()
                
                if isLoading.wrappedValue {
                    LoadingView()
                } else {
                    VStack {
                        PhotosPicker(selection: selectedItem, matching: .images, photoLibrary: .shared()) {
                            ZStack {
                                Circle()
                                    .strokeBorder(Color.purple, lineWidth: 3)
                                    .frame(width: 200, height: 200)
                                    .background(Circle().fill(Color.black))
                                
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                        Text("Select a photo to analyze")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                    }
                }
                
                Spacer()
            }
        }
    }
} 