import Foundation

struct PhysiqueAnalysis: Equatable {
    var overallScore: Int
    var attributes: [PhysiqueAttribute]
    var feedback: String
    
    struct PhysiqueAttribute: Equatable, Identifiable {
        let id = UUID()
        var name: String
        var score: Int
        var feedback: String
    }
} 