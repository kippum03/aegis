//
//  ContentView.swift
//  Project-Aegis
//
//  Created by Eric Kim on 4/27/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isEmergencyActive = false
    @State private var countdown = 15
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer()

                VStack(spacing: 10) {
                    Text("Aegis")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("Evidence-first safety recording")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                if isEmergencyActive {
                    emergencyActiveView
                } else {
                    standbyView
                }

                Spacer()
            }
            .padding()
        }
    }

    private var standbyView: some View {
        VStack(spacing: 20) {
            Text("Ready")
                .font(.title2)
                .foregroundColor(.white)

            Text("Trigger emergency mode to begin recording and prepare trusted-contact escalation.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Button {
                startEmergencySession()
            } label: {
                Text("Start Emergency Session")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
            }
        }
    }

    private var emergencyActiveView: some View {
        VStack(spacing: 20) {
            Text("Recording Active")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.red)

            Text("Alert will be sent in \(countdown) seconds unless canceled.")
                .font(.body)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Button {
                cancelEmergencySession()
            } label: {
                Text("I'm Safe")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(16)
            }

            Button {
                sendAlertNow()
            } label: {
                Text("Send Alert Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(16)
            }

            Button {
                soundAlarm()
            } label: {
                Text("Sound Alarm")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
        }
    }

    private func startEmergencySession() {
        isEmergencyActive = true
        countdown = 15

        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                sendAlertNow()
            }
        }
    }

    private func cancelEmergencySession() {
        timer?.invalidate()
        timer = nil
        countdown = 15
        isEmergencyActive = false
    }

    private func sendAlertNow() {
        timer?.invalidate()
        timer = nil

        // Later: send trusted-contact alert
        print("Alert sent to trusted contacts")

        isEmergencyActive = false
        countdown = 15
    }

    private func soundAlarm() {
        // Later: activate loud alarm
        print("Sound alarm activated")
    }
}

#Preview {
    ContentView()
}
