//
//  ContentView.swift
//  Baseball
//
//  Created by David on 1/18/21.
//

import SwiftUI

struct ContentView: View {
    var game: Game
    //@EnvironmentObject var game: Game
    
    // per Scene storage - not App storage - Scene is an instance of the App running on the device
    // remember which tab View we were on last time we ran the app
    @SceneStorage("selectedView") var selectedView: String?
    
    var body: some View {
        TabView(selection: $selectedView) {
            ScoreSheetView(game: game)
                .tag(ScoreSheetView.tag)
                .tabItem {
                    Image(systemName: "scroll")
                    Text("ScoreSheet")
                }
                .accessibilityElement().accessibility(identifier: "scoresheet_button_tabbar") // works

            ScoreGameView(game: game)
                .tag(ScoreGameView.addGameTag)
                .tabItem {
                    Image(systemName: "rectangle.stack.badge.plus")
                    Text("Add Game")
                }
                .accessibilityElement().accessibility(identifier: "addGame_button_tabbar") // works
            
            ConfigView(game: game)
                .tag(ConfigView.configTag)
                .tabItem {
                    Image(systemName: "slider.horizontal.3")
                    Text("Config")
                }
                .accessibilityElement().accessibility(identifier: "config_button_tabbar") // works
            
//            AwardsView()
//                .tag(AwardsView.tag)
//                .tabItem {
//                    Image(systemName: "rosette")
//                    Text("Awards")
//                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  
    static var previews: some View {
        ContentView(game: Game.makeStaticGame())
           // .environmentObject( Game(innings: Game.exampleInnings) )
    }
    
}
