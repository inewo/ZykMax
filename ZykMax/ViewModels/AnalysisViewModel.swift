import Foundation
import UIKit

class AnalysisViewModel: ObservableObject {
    @Published var analysis: PhysiqueAnalysis?
    @Published var isAnalyzing = false
    @Published private(set) var userInfo: UserPhysiqueInfo?
    
    func setUserInfo(_ info: UserPhysiqueInfo) {
        userInfo = info
    }
    
    func analyzePhysique(image: UIImage, userInfo: UserPhysiqueInfo) async throws -> PhysiqueAnalysis {
        // Simulate analysis for now
        try await Task.sleep(for: .seconds(2))
        
        // Use userInfo to provide more accurate analysis
        let baseScore = 85
        let potentialModifier = max(0, min(5, Int(userInfo.yearsOfTraining)))
        
        return PhysiqueAnalysis(
            overallScore: baseScore + potentialModifier,
            attributes: [
                .init(name: "Potential", score: 90, feedback: "Excellent genetic potential for \(userInfo.age) years old"),
                .init(name: "Symmetry", score: 85, feedback: "Good left-right balance"),
                .init(name: "Proportion", score: 88, feedback: "Well-balanced muscle distribution"),
                .init(name: "Conditioning", score: 82, feedback: "Good muscle definition"),
                .init(name: "Mass", score: 84, feedback: "Solid muscle development for \(Int(userInfo.weight))lbs")
            ],
            feedback: "Impressive physique with \(String(format: "%.1f", userInfo.yearsOfTraining)) years of training. Focus on maintaining symmetry while building mass."
        )
    }
} 