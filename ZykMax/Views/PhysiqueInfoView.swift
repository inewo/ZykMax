import SwiftUI

struct PhysiqueInfoView: View {
    let image: UIImage
    var onComplete: (UserPhysiqueInfo) -> Void
    var onBack: () -> Void
    
    @State private var gender: UserPhysiqueInfo.Gender = .male
    @State private var age: String = ""
    @State private var heightFeet: String = ""
    @State private var heightInches: String = ""
    @State private var weight: String = ""
    @State private var yearsOfTraining: String = ""
    
    var canProceed: Bool {
        !age.isEmpty && !heightFeet.isEmpty && !heightInches.isEmpty && 
        !weight.isEmpty && !yearsOfTraining.isEmpty &&
        Int(age) != nil && Int(heightFeet) != nil && Int(heightInches) != nil &&
        Double(weight) != nil && Double(yearsOfTraining) != nil
    }
    
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
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                    
                    VStack(spacing: 25) {
                        // Gender Selection
                        VStack(alignment: .leading) {
                            Text("Gender")
                                .foregroundColor(.white)
                            
                            Picker("Gender", selection: $gender) {
                                Text(UserPhysiqueInfo.Gender.male.rawValue)
                                    .tag(UserPhysiqueInfo.Gender.male)
                                Text(UserPhysiqueInfo.Gender.female.rawValue)
                                    .tag(UserPhysiqueInfo.Gender.female)
                            }
                            .pickerStyle(.segmented)
                            .colorScheme(.dark)
                        }
                        
                        // Age Input
                        InfoInputField(title: "Age", value: $age, placeholder: "Enter age", keyboardType: .numberPad)
                        
                        // Height Input
                        VStack(alignment: .leading) {
                            Text("Height")
                                .foregroundColor(.white)
                            
                            HStack {
                                TextField("Feet", text: $heightFeet)
                                    .keyboardType(.numberPad)
                                    .modifier(InfoInputModifier())
                                    .frame(width: 80)
                                
                                Text("ft")
                                    .foregroundColor(.gray)
                                
                                TextField("Inches", text: $heightInches)
                                    .keyboardType(.numberPad)
                                    .modifier(InfoInputModifier())
                                    .frame(width: 80)
                                
                                Text("in")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Weight Input
                        InfoInputField(title: "Weight (lbs)", value: $weight, placeholder: "Enter weight", keyboardType: .decimalPad)
                        
                        // Years of Training Input
                        InfoInputField(title: "Years of Training", value: $yearsOfTraining, placeholder: "Enter years", keyboardType: .decimalPad)
                    }
                    .padding(.horizontal)
                    
                    // Buttons
                    VStack(spacing: 15) {
                        Button(action: {
                            let totalHeightInInches = (Double(heightFeet) ?? 0) * 12 + (Double(heightInches) ?? 0)
                            let info = UserPhysiqueInfo(
                                gender: gender,
                                age: Int(age) ?? 0,
                                height: totalHeightInInches,
                                weight: Double(weight) ?? 0,
                                yearsOfTraining: Double(yearsOfTraining) ?? 0
                            )
                            print("Selected gender: \(gender)")
                            onComplete(info)
                        }) {
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.yellow)
                                Text("Continue to Analysis")
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(canProceed ? Color.purple : Color.purple.opacity(0.3))
                            )
                        }
                        .disabled(!canProceed)
                        .padding(.horizontal)
                        
                        Button(action: onBack) {
                            Text("Choose Different Photo")
                                .foregroundColor(.yellow)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.purple, lineWidth: 2)
                                )
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct InfoInputField: View {
    let title: String
    let value: Binding<String>
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.white)
            
            TextField(placeholder, text: value)
                .keyboardType(keyboardType)
                .modifier(InfoInputModifier())
        }
    }
}

struct InfoInputModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.purple.opacity(0.2))
            .cornerRadius(10)
            .foregroundColor(.white)
    }
} 