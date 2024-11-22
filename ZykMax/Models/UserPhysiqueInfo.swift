import Foundation

struct UserPhysiqueInfo: Equatable {
    var gender: Gender
    var age: Int
    var height: Double // in inches
    var weight: Double // in pounds
    var yearsOfTraining: Double
    
    enum Gender: String, CaseIterable {
        case male = "Male"
        case female = "Female"
        
        var description: String {
            return self.rawValue
        }
    }
} 