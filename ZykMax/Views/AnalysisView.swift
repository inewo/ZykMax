import SwiftUI

struct AnalysisView: View {
    let image: UIImage
    @EnvironmentObject private var viewModel: AnalysisViewModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    Text("ZykMax")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    if viewModel.isAnalyzing {
                        LoadingView()
                    } else if let analysis = viewModel.analysis {
                        // Image with overall score overlay
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                            
                            // Overall Score Circle
                            ZStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 80, height: 80)
                                
                                VStack {
                                    Text("\(analysis.overallScore)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text("Overall")
                                        .font(.caption)
                                }
                                .foregroundColor(.white)
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                        
                        // Attribute Scores
                        VStack(spacing: 15) {
                            ForEach(analysis.attributes) { attribute in
                                AttributeScoreView(attribute: attribute)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Overall Feedback
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Analysis")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.yellow)
                            
                            Text(analysis.feedback)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.purple.opacity(0.2))
                                )
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    } else {
                        Text("Starting Analysis...")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .task {
            do {
                guard let userInfo = viewModel.userInfo else {
                    print("User info not found")
                    return
                }
                
                viewModel.isAnalyzing = true
                viewModel.analysis = try await viewModel.analyzePhysique(image: image, userInfo: userInfo)
            } catch {
                print("Analysis failed: \(error)")
            }
            viewModel.isAnalyzing = false
        }
    }
}

struct AttributeScoreView: View {
    let attribute: PhysiqueAnalysis.PhysiqueAttribute
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(attribute.name)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Spacer()
                
                Text("\(attribute.score)")
                    .foregroundColor(.yellow)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            // Score Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.purple.opacity(0.2))
                    
                    Rectangle()
                        .fill(Color.purple)
                        .frame(width: geometry.size.width * CGFloat(attribute.score) / 100)
                }
            }
            .frame(height: 8)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            
            Text(attribute.feedback)
                .font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
} 