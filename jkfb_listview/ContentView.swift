//
//  ContentView.swift
//  jkfb_listview
//
//  Created by ITB103-COMP13 on 5/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isDarkMode = false
    @State private var showOptions = false

    @State var isFavorite = Array(repeating: false, count: 21)
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(restaurantNames.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Image(restaurantNames[index])
                            .resizable()
                            .frame(width: 285, height: 200)
                            .cornerRadius(20)
                        HStack{
                            Text(restaurantNames[index])
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(isDarkMode ? .white : .black)
                            if isFavorite[index] {
                                Text("💛")
                            }
                        }
                        Text(restaurantLocations[index])
                            .font(.system(size: 20))
                            .foregroundColor(isDarkMode ? .white : .black)
                        Text(restaurantTypes[index])
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .opacity(isDarkMode ? 1.0 : 0.6)
                    }.onTapGesture{
                        showOptions.toggle()
                    }
                    .sheet(isPresented: $showOptions){
                        OptionsDialog(isPresented: $showOptions, isFavorite: $isFavorite, favIndex: index)
                    }
                }
            }
            
            Button(action: {
                isDarkMode.toggle()
            }) {
                Text(isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode")
                    .foregroundColor(isDarkMode ? .white : .black)
                    .padding()
                    .background(isDarkMode ? Color.black : Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray, radius: 2)
            }
            .padding()
        }
        .padding(.top)
        .background(isDarkMode ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct OptionsDialog: View {
    @Binding var isPresented: Bool
    @Binding var isFavorite: [Bool]
    var favIndex: Int
    @State private var alertPopup = false
    @State private var favoriteIndex: Int?
    
    var body: some View{
        VStack{
            Text("What do you want to do?")
            Button("Reserve a Table"){
                alertPopup.toggle()
            }
            .alert(isPresented: $alertPopup) {
                Alert(title: Text("Table Reserved"))
            }
            Button("Mark as Favorite"){
                isFavorite[favIndex].toggle()
                isPresented = false
            }
        }
        .onAppear {
            favoriteIndex = nil
        }
        .onChange(of: favoriteIndex) { newIndex in
            if let index = newIndex {
                isFavorite[index] = true
                isPresented = false
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

