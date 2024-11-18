//
//  DeleteConfirmation.swift
//  ClosetCompanion
//
//  Created by Jacob Michalik on 10/13/24.
//

import SwiftUI

struct DeleteConfirmation: View {
    @Binding var deleteIsActive: Bool
    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    
    var body: some View {
        ZStack{
            Color(.black)
                .opacity(0.5)
                .onTapGesture {
                    close()
                }
            VStack{
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()
                Text(message)
                    .font(.body)
                Button {
                    action()
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.red)
                        
                        Text(buttonTitle)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay{
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            close()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .fontWeight(.medium)
                        }
                        .tint(.black)
                    }
                    Spacer()
                }
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
        }
        .ignoresSafeArea()
    }
    
    func close() {
        deleteIsActive = false
    }
}
