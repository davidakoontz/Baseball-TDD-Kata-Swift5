//
//  GameTest.swift
//  Baseball-Tests
//
//  Created by David on 12/23/20.
//

import XCTest
@testable import Baseball

class GameTest: XCTestCase {
    
    func test_init() {
        let game = Game()
        
        XCTAssertEqual(game.innings.count, 9)
        XCTAssertEqual(game.inningIndex, 0)
    }
    
    
    func test_appendInning_AddExtraInning() {
        let game = Game()   // upon creation game has 9 innings
        let extra = Inning(label: "", game: game, top: [], bottom: [])
       
        game.appendInning(inning: extra)
        
        XCTAssertEqual(game.inningCount(), 10)
    }

    
    func test_next_SequenceIterator() {
        let game = Game()   // created with 9 innings
        let firstInning = game.currentInning()
        
        XCTAssertEqual(game.currentInning().label, "1")
        XCTAssertEqual(game.inningCount(), 9)

        let secondInning = game.next()!
        let thridInning = game.next()!
        
        XCTAssertEqual( firstInning.label, "1")
        XCTAssertEqual( secondInning.label, "2")
        XCTAssertEqual( thridInning.label, "3")
        
        for i in 0..<9 {
            print("Game: i\(i) Inning #\(game.innings[i].label)")
        }
        
    }
    
    func test_scoreAdd_forVisitorTeam() {
        let game = Game()
        let first = Inning(label: "1", game: game, top: [], bottom: [])
        
        game.appendInning(inning: first)
        
        game.score.Add(runs: 1, teamAtBat: Team.visitor)
        
        XCTAssertEqual(game.score.visitor, 1)
    }

    func test_scoreAdd_forHomeTeam() {
        let game = Game()
        let first = Inning(label: "1", game: game, top: [], bottom: [])
        
        game.appendInning(inning: first)
        
        game.score.Add(runs: 3, teamAtBat: Team.home)
        
        XCTAssertEqual(game.score.home, 3)
    }
    
    func test_batterUp_FactoryMethodForPlayWrappsArroundLineUp() {
        let game = Game()
        let first = game.currentInning()

        game.setVisitorTeamLineUp()
        
        let play1 = game.batterUp()
        XCTAssertEqual(play1.batter.name, "Duke Java")
        
        let play2 = game.batterUp()
        XCTAssertEqual(play2.batter.name, "James Gosling")
        
        let play3 = game.batterUp()
        XCTAssertEqual(play3.batter.name, "Scott McNealy")
        
        let play4 = game.batterUp()
        XCTAssertEqual(play4.batter.name, "Bill Joy")
        
        let play5 = game.batterUp()
        XCTAssertEqual(play5.batter.name, "Andy Bechtolsheim")
        
        let play6 = game.batterUp()
        XCTAssertEqual(play6.batter.name, "Larry Ellison")
        
        let play7 = game.batterUp()
        XCTAssertEqual(play7.batter.name, "Sun Li")
        
        let play8 = game.batterUp()
        XCTAssertEqual(play8.batter.name, "Sun Tzu")
        
        let play9 = game.batterUp()
        XCTAssertEqual(play9.batter.name, "Nike Sun")
        
        // a LineUp should have no problem wrapping around the front again & again.
        let play10 = game.batterUp()
        XCTAssertEqual(play10.batter.name, "Duke Java")
    }
    
    
    func test_switchFields_SwitchesTeamsAsHalfInningAndEnd() {
        let game = Game()       // created with 9 innings
        
        game.setVisitorTeamLineUp()
        game.setHomeTeamLineUp()
        
        let play1 = game.batterUp()
        XCTAssertEqual(play1.batter.name, "Duke Java")
        
        let play2 = game.batterUp()
        XCTAssertEqual(play2.batter.name, "James Gosling")
        
        let play3 = game.batterUp()
        XCTAssertEqual(play3.batter.name, "Scott McNealy")
        
        // Need a method to call to make model aware
        game.switchFields()
        
        // assume 3 outs for Visitors - switch teams at Bat
        
        let play4 = game.batterUp()
        XCTAssertEqual(play4.batter.name, "Taylor Swift")
        
        let play5 = game.batterUp()
        XCTAssertEqual(play5.batter.name, "Bill Swift")
        
        let play6 = game.batterUp()
        XCTAssertEqual(play6.batter.name, "Jonathan Swift")
        
        // end of inning
        let inning = game.next()       // get next inning
        XCTAssertEqual(inning?.label, "2")
        XCTAssertEqual(game.teamAtBat, Team.visitor)
        XCTAssertEqual(game.currentInning().label, "2")
       
    }
    
    func test_setLineUp_withList() {
        let game = Game()
        
        game.setVisitorTeamLineUp()
        game.setLineUp(lineUp: game.getDefaultTeamLineUp(), team: Team.home)
        
        
        XCTAssertEqual(game.visitorLineUp.theLineup.count, 9)
        XCTAssertEqual(game.homeLineUp.theLineup.count, 9)
        
        XCTAssertEqual(game.batterUp().batter.name, "Duke Java")
    }
    
    
}
