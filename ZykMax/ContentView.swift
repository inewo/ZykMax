//
//  ContentView.swift
//  ZykMax
//
//  Created by Owen Ingerson on 11/21/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var analysisVM = AnalysisViewModel()
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigationPath = NavigationPath()
    @State private var userInfo: UserPhysiqueInfo?
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            HomeView(
                isLoading: $isLoading,
                selectedItem: $selectedItem,
                onImageSelected: handleImageSelection
            )
            .navigationDestination(for: UIImage.self) { image in
                PhysiqueInfoView(
                    image: image,
                    onComplete: { info in
                        userInfo = info
                        analysisVM.setUserInfo(info)
                        DispatchQueue.main.async {
                            navigationPath.append(Route.analysis(image))
                        }
                    },
                    onBack: {
                        selectedItem = nil
                        selectedImage = nil
                        navigationPath = NavigationPath()
                    }
                )
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .analysis(let image):
                    AnalysisView(image: image)
                        .environmentObject(analysisVM)
                }
            }
        }
        .onChange(of: selectedItem) { newItem in
            handleImageSelection(newItem)
        }
        .alert("Error", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func handleImageSelection(_ newItem: PhotosPickerItem?) {
        guard let newItem else { 
            print("No item selected")
            return 
        }
        
        isLoading = true
        print("Starting image processing...")
        
        Task {
            do {
                guard let imageData = try await newItem.loadTransferable(type: Data.self) else {
                    print("Failed to load image data")
                    throw URLError(.badServerResponse)
                }
                
                guard let uiImage = UIImage(data: imageData) else {
                    print("Failed to create UIImage from data")
                    throw URLError(.badServerResponse)
                }
                
                print("Image loaded successfully, size: \(uiImage.size)")
                
                // Simulate processing time
                try await Task.sleep(for: .seconds(2))
                
                await MainActor.run {
                    selectedImage = uiImage
                    isLoading = false
                    navigationPath.append(uiImage)
                    print("Image processing completed")
                }
            } catch {
                print("Error occurred: \(error.localizedDescription)")
                await MainActor.run {
                    errorMessage = error.localizedDescription
                    showError = true
                    isLoading = false
                }
            }
        }
    }
}

enum Route: Hashable {
    case analysis(UIImage)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .analysis(let image):
            hasher.combine(ObjectIdentifier(image))
        }
    }
}
