//
//  Play.swift
//  Baseball-TDD
//
//  Created by David on 10/4/20.
//

import Foundation

// Global variable
var sequenceNumber: Int = 0

// A baseball play typically starts with a pitch and then the batter may or may not swing and hit the ball.
// The play continues if the batter hits the ball (In Play) and then the fielders get the ball and try to
// throw the ball to an infielder to tag a player or the base.
//
public class Play: Identifiable {
    var number: Int
    public var id = UUID().uuidString     //  for Identifiable protocol
    var game: Game
    /// unique to each play
    var description: String
    var batter: Player
    var atBat: AtBat
    
    var runnerOutcomes : RunnerOutcomes
    
    
    init(game: Game, description: String, batter: Player) {
        self.game = game                        // a play needs to know the Game so it can access the bases, etc.
        sequenceNumber += 1                     // increment the number
        self.number = sequenceNumber            // sequence count of the plays in the game
        self.description = description          // imagine the announcer calling the game
        self.batter = batter                    // the Player at bat
        // more properties
        self.atBat = AtBat.inBox              // Batter in the batter's Box - still at bat
        runnerOutcomes = RunnerOutcomes()
    }
    
    
    init(game: Game, description: String, batter: Player, atBat: AtBat) {
        self.game = game                        // a play needs to know the Game so it can access the bases, etc.
        sequenceNumber += 1                     // increment the number
        self.number = sequenceNumber            // sequence count of the plays in the game
        self.description = description          // imagine the announcer calling the game
        self.batter = batter                    // the Player at bat
        // more properties
        self.atBat = atBat                      // Batter in the batter's Box - still at bat
        runnerOutcomes = RunnerOutcomes()
    }
    
    func umpCalled(_ atBat: AtBat) {        // called by Umpire
        self.atBat = atBat
        switch atBat {
        case .homeRun:
            game.bases.homePlate = batter
            runnerOutcomes.firstBaseLine = atBat
        case .triple:
            game.bases.thirdBase = batter
            runnerOutcomes.firstBaseLine = atBat
        case .double:
            game.bases.secondBase = batter
            runnerOutcomes.firstBaseLine = atBat
        case .single:
            game.bases.firstBase = batter
            runnerOutcomes.firstBaseLine = atBat
            
        // Outs of some kind
        case .doublePlay:
            game.bases.secondBase = EmptyPlayer()
            game.playerOut()
            game.bases.firstBase = EmptyPlayer()
            game.playerOut()
            runnerOutcomes.secondBaseLine = RunnerActions.doublePlay
            runnerOutcomes.firstBaseLine = atBat
        case .flyOut:
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
        case .foulOut:
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
        case .groundOut:
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
        case .strikeoutSwinging:
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
        case .strikeoutLooking:
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
        case .lineOut:
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
        case .sacrificeFly:
            //game.bases.firstBase = EmptyPlayer()
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
        case .sacrificeHit:
            //game.bases.firstBase = EmptyPlayer()
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
        case .triplePlay:
            game.bases.thirdBase = EmptyPlayer()
            game.playerOut()
            game.bases.secondBase = EmptyPlayer()
            game.playerOut()
            game.bases.firstBase = EmptyPlayer()
            game.playerOut()
            runnerOutcomes.thirdBaseLine = RunnerActions.triplePlay
            runnerOutcomes.secondBaseLine = RunnerActions.triplePlay
            runnerOutcomes.firstBaseLine = atBat
        case .unassistedOut:
            runnerOutcomes.firstBaseLine = atBat
            game.playerOut()
            
        // batter advances to first
        case .error:
            game.bases.firstBase = batter
            runnerOutcomes.firstBaseLine = atBat
        case .hitByPitch:
            game.bases.firstBase = batter
            runnerOutcomes.firstBaseLine = atBat
        case .interference:
            game.bases.firstBase = batter
            runnerOutcomes.firstBaseLine = atBat
        case .intentionalWalk:
            game.bases.firstBase = batter
            runnerOutcomes.firstBaseLine = atBat
        case .passedBall:
            game.bases.firstBase = batter
            runnerOutcomes.firstBaseLine = atBat
        case .wildPitch:
            game.bases.firstBase = batter
            runnerOutcomes.firstBaseLine = atBat
  
        default:
            game.bases.firstBase = batter
            runnerOutcomes.firstBaseLine = atBat
        }
    }

} // end of class Play

class EmptyPlay : Play {
    init(theGame: Game) {
        super.init(game: theGame, description: "Empty Play", batter: EmptyPlayer() )
    }
}


