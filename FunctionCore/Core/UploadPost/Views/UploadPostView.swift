//
//  UploadPostView.swift
//  UniPop-App
//
//  Created by Carly Googel on 6/6/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {

    // Adding logic to update status to post
    @State private var showingAlert = false
    @State private var enterEmail = ""
    

    @State private var itemName  = ""
    @State private var description = ""
    @State private var category = ""
    @State private var itemPrice = ""
    @State private var isEventTicket: Bool = false
    @State private var listAnonymously: Bool = false
    
    @State private var imagePickerPresented = false
    @StateObject var viewModel = UploadPostViewModel()

   // @StateObject var userStatusViewModel = UserStatusViewModel()


    // added under

    @StateObject var viewModelCurrentUser = CurrentUserViewModel()

    private var userCurrent: User? {
        return viewModelCurrentUser.currentUser
    }

    // added above


    // try changing to environment object

    @Binding var tabIndex: Int

  //  @ObservedObject var userStatusViewModel = UserStatusViewModel()
   //  @StateObject var userStatusViewModel =  UserStatusViewModel()


    var body: some View {
        ZStack {
            VStack {
                // item image
                ZStack {

                    Rectangle()
                        .foregroundColor(Color(hex: "EEEEEE"))
                        .frame(width: 344, height: 148)

                        .cornerRadius(10)
                        .padding()




                    Button(action: {
                        imagePickerPresented.toggle()
                    }) {

                        if let image = viewModel.postImage {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 344, height: 148)
                                .cornerRadius(10)
                                .clipped()
                                .padding()

                        } else {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 25)
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(100)
                                .shadow(radius: 5)
                        }

                    }

                }
                .padding(.top, 20)

                // name, description category
                VStack(alignment: .leading, spacing: 10) {

                    Text("Item name")
                        .padding(.top, 10)
                        .fontWeight(.semibold)


                    TextField("", text: $itemName, axis: .vertical)
                        .modifier(TextFieldModifier2())
                        .frame(width: 344, height: 50)
                        .foregroundColor(.black)



                    Text("Description")
                        .padding(.top, 10)
                        .fontWeight(.semibold)



                    TextField("", text: $description, axis: .vertical)
                        .modifier(TextFieldModifier2())
                        .frame(width: 344, height: 50)
                        .foregroundColor(.black)




                    Text("Category")
                        .padding(.top, 10)
                        .fontWeight(.semibold)



//                    TextField("", text: $category, axis: .vertical)
//                        .modifier(TextFieldModifier2())
//                        .frame(width: 344, height: 50)
//                        .foregroundColor(.black)






                    ZStack(alignment: .leading) {

                            TextField("", text: $category, axis: .vertical)
                                .modifier(TextFieldModifier2())
                                .frame(width: 344, height: 50)
                                .foregroundColor(.white)
                                .disabled(true)



                            Picker("", selection: $category) {
                                Text("Cool items").tag("Cool items")
                                Text("Hot outfits").tag("Hot outfits")
                                Text("Services").tag("Services")
                                Text("Tickets").tag("Tickets")
                                Text("Greek life").tag("Greek life")
                                Text("Other").tag("Other")
                            }
                            .pickerStyle(MenuPickerStyle())
                          //  .frame(width: 200)
                            .opacity(0.02)

                    }




                }
                .onTapGesture {
                    self.endEditing()
                }
                .padding(.horizontal)


                // price and bool questions
                HStack {
                    // price
                    VStack(alignment: .leading) {
                        Text("Item Price")
                            .padding(.top, 10)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)



                        TextField("US$ 0.00", text: $itemPrice)
                            .modifier(TextFieldModifier2())
                            .keyboardType(.decimalPad)
                        //   .padding(.horizontal)
                            .padding(.top, 10)
                            .frame(height: 50)

                    }

                    Spacer()

                    // bool buttons
                    VStack(alignment: .leading) {
                        VStack() {

                            Text("Event Ticket")
                                .padding(.top, 20)
                                .fontWeight(.semibold)
                                .font(.footnote)




                            Toggle("", isOn: $isEventTicket)
                                .padding(.top, 10)
                                .frame(width: 100)

                        }

                        VStack() {

                            Text("List Anonymously")
                                .padding(.top, 10)
                                .fontWeight(.semibold)
                                .font(.footnote)


                            Toggle("", isOn: $listAnonymously)
                                .padding(.top, 10)
                                .frame(width: 100)
                        }

                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .padding(.horizontal)

                Spacer()

                // Post button
                HStack() {
                    Button {
                        print("cancel upload")
                        clearPostDataAndReturnToFeed()


                    } label: {
                        Text("Cancel")
                            .font(.title3)
                            .fontWeight(.black)
                            .frame(width: 130, height: 30)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "E5E3E3"), Color(hex: "E5E3E3")]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.black)
                            .cornerRadius(10)

                        // E5E3E3
                    }

                    Button {

                        Task {
                            try await viewModel.uploadPost(itemName: itemName, description: description, category: category, itemPrice: itemPrice)

                            clearPostDataAndReturnToFeed()
                        }
                    } label: {
                        Text("Post")
                            .font(.title3)
                            .fontWeight(.black)
                            .frame(width: 130, height: 30)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color(hex: "E64FFF"), Color(hex: "76F6FE")]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }


                }
            }
            .padding(.horizontal, 5)
            .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedImage)
          //  .blur(radius: userStatusViewModel.currentUser?.status ?? true ? 0 : 3) // Blur background when form is shown
            .blur(radius: userCurrent?.status ?? true ? 0 : 3)

//              if !(userStatusViewModel.currentUser?.submittedForm ?? true) && !(userStatusViewModel.currentUser?.status ?? true) {
//              Color.black.opacity(0.5)
//                 .edgesIgnoringSafeArea(.all)
//              RequestStatusSuccessView(tabIndex: .constant(0))
//              }
// userCurrent

              //  if !(userStatusViewModel.currentUser?.status ?? true) {
            if !(userCurrent?.status ?? true) {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)

                    //if (userStatusViewModel.currentUser?.submittedForm ?? false) {
                if (userCurrent?.submittedForm ?? false) {

                        RequestStatusSuccessView()
                    } else {

                        RequestStatusView()
                    }

                }




        }

    }



    func clearPostDataAndReturnToFeed() {
        itemName = ""
        description = ""
        category = ""
        itemPrice = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(1))
}


extension UploadPostView {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
