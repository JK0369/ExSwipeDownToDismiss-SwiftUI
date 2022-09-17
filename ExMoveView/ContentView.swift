//
//  ContentView.swift
//  ExMoveView
//
//  Created by 김종권 on 2022/09/17.
//

import SwiftUI
import Combine

struct ContentView: View {
  @State private var draggedOffset = CGSize.zero
  @State private var isActive = false
  
  var body: some View {
    NavigationView {
      NavigationLink(
        isActive: $isActive,
        destination: {
          Image("background")
            .offset(draggedOffset)
            .gesture(swipeDownToDismiss)
        },
        label: {
          Text("다음 화면")
        }
      )
    }
  }
  
  var swipeDownToDismiss: some Gesture {
    DragGesture()
      .onChanged { gesture in
        guard gesture.location.x > 30 else { return }
        draggedOffset = gesture.translation
      }
      .onEnded { gesture in
        if checkIsDismissable(gesture: gesture) {
          isActive = false
        }
        draggedOffset = .zero
      }
  }
  
  func checkIsDismissable(gesture: _ChangedGesture<DragGesture>.Value) -> Bool {
    let dismissableLocation = gesture.translation.height > 50
    let dismissableVolocity = (gesture.predictedEndLocation - gesture.location).y > 50
    return dismissableLocation || dismissableVolocity
  }
}

extension CGPoint {
  static func - (lhs: Self, rhs: Self) -> Self {
    CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
  }
}
