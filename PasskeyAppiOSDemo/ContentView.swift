//
//  ContentView.swift
//  PasskeyAppiOSDemo
//
//  Created by Tim Wang on 20/1/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModle = ViewModel()
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            TextField("Enter your name",
                      text: $viewModle.userName,
                      onEditingChanged: { _ in
                viewModle.autoFillAssistedPasskeySignIn()
            })
            .textContentType(.username)
            .padding(.init(top: 0, leading: 50, bottom: 0, trailing: 50))

            Button("Sign in") {
                viewModle.signIn()
            }
            Button("Register") {
                viewModle.register()
            }
            Spacer()

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
