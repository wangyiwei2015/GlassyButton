// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct GlassyButton: ViewModifier {
    public var tint: Color
    public func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content.buttonStyle(.glassProminent).tint(tint)
        } else {
            content.buttonStyle(FallbackGlassButtonStyle(tint: tint))
        }
    }
}

public extension View {
    func glassyButton(_ tint: Color = .primary) -> some View {
        modifier(GlassyButton(tint: tint))
    }
}

struct FallbackGlassButtonStyle: ButtonStyle {
    var tint: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8).padding(.horizontal, 4)
            .background(tint.opacity(0.7), in: Capsule())
            .background(.ultraThinMaterial, in: Capsule())
            .compositingGroup()
            .overlay {
                Capsule().stroke(
                    LinearGradient(colors: [
                        Color.white.opacity(0.4),
                        Color.white.opacity(0.1),
                        Color.white.opacity(0.4)
                    ], startPoint: .topLeading, endPoint: .bottomTrailing
                    ), lineWidth: 1
                )
            }.overlay {
                Capsule().fill(Color.white.opacity(
                    configuration.isPressed ? 0.4 : 0
                ))
            }
            .shadow(color: .black.opacity(0.2), radius: 16, y: 4)
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(
                .smooth(duration: 0.3),// extraBounce: 0.3),
                value: configuration.isPressed
            )
    }
}

#Preview {
    HStack(spacing: 0) {
        Color.white
        Color.black
    }.overlay {
        VStack {
            Button {} label: {
                Label("LabelText", systemImage: "swift")
                    .padding(8)
            }.glassyButton(.green)
            
            Button {} label: {
                Label("LabelText", systemImage: "swift")
                    .padding(8)
            }.buttonStyle(FallbackGlassButtonStyle(tint: .green))
        }
    } // overlay
}
