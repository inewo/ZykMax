import SwiftUI

struct LoadingView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.purple.opacity(0.2), Color.purple]),
                        center: .center
                    ),
                    lineWidth: 8
                )
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
            
            Circle()
                .fill(Color.black)
                .frame(width: 180, height: 180)
            
            Image(systemName: "bolt.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.yellow)
        }
    }
} 