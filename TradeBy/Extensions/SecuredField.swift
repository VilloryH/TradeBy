import SwiftUI

struct LoginSecureField: View {
    @Binding var field: String
    @Binding var isSecured: Bool
    let placeholder: String
    var body: some View {
        HStack {
            HStack(spacing: 0) {
                if isSecured {
                    SecureField("", text: $field)
                        .padding(.horizontal)
                        .placeholder(when: field.isEmpty) {
                            HStack {
                                Spacer()
                                Text(placeholder)
                                    .foregroundColor(.gray)
                                    .bold()
                                    .opacity(0.6)
                                Spacer()
                            }
                        }
                        .overlay(
                            HStack {
                                Spacer()
                                Button {
                                    isSecured.toggle()
                                }
                            label: {
                                    Image(systemName: isSecured ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 10)
                            }
                        )
                }
                else {
                    TextField("", text: $field)
                        .padding(.horizontal)
                        .placeholder(when: field.isEmpty) {
                            HStack {
                                Spacer()
                                Text(placeholder)
                                    .foregroundColor(.gray)
                                    .bold()
                                    .opacity(0.6)
                                Spacer()
                            }
                        }
                        .overlay(
                            HStack {
                                Spacer()
                                Button {
                                    isSecured.toggle()
                                }
                            label: {
                                    Image(systemName: isSecured ? "eye.slash" : "eye")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 10)
                            }
                        )
                }
//                Button {
//                    isSecured.toggle()
//                } label: {
//                    Image(systemName: isSecured ? "eye" : "eye.slash")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 25, height: 25)
//                        .foregroundColor(Color.gray)
//                        .padding()
//                }
            }
            .frame(height: 40)
            .foregroundColor(.black)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 35, style: .continuous))
        }
    }
}
