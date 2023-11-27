enum Difficulty: Codable {
    case easy
    case normal
    case hard
}

import Foundation

final class SettingsDifficultyGame {
    
    // Settings OxygenScale
    var timeIntervalOxygenScale: Double
    
    // Settings Fish
    var timeDurationFish: Double
    var timeDelayFish: Double
    var timerIntervalFish: Double
    
    // Settings Ship
    var timeDurationShip: Double
    var timeDelayShip: Double
    var timerIntervalShip: Double
    
    // Settings BottomObstacles
    var timeDurationBottomObstacles: Double
    var timeDelayBottomObstacles: Double
    var timerIntervalBottomObstacles: Double
    
    // other
    var difficultyPoints: Int
    
    init(difficulty: Difficulty){
        switch difficulty {
        case .easy:
            // Settings OxygenScale
            timeIntervalOxygenScale = 20
            
            // Settings Fish
            timeDurationFish = 19
            timeDelayFish = 3
            timerIntervalFish = timeDurationFish + timeDelayFish
            
            // Settings Ship
            timeDurationShip = 17
            timeDelayShip = 3
            timerIntervalShip = timeDurationShip + timeDelayShip
            
            // Settings BottomObstacles
            timeDurationBottomObstacles = 30
            timeDelayBottomObstacles = 5
            timerIntervalBottomObstacles = timeDurationBottomObstacles + timeDelayBottomObstacles
            
            // other
            difficultyPoints = 20
            
        case .normal:
            // Settings OxygenScale
            timeIntervalOxygenScale = 12
            
            // Settings Fish
            timeDurationFish = 11
            timeDelayFish = 2
            timerIntervalFish = timeDurationFish + timeDelayFish
            
            // Settings Ship
            timeDurationShip = 9
            timeDelayShip = 2
            timerIntervalShip = timeDurationShip + timeDelayShip
            
            // Settings BottomObstacles
            timeDurationBottomObstacles = 20
            timeDelayBottomObstacles = 3
            timerIntervalBottomObstacles = timeDurationBottomObstacles + timeDelayBottomObstacles
            
            // other
            difficultyPoints = 50
            
        case .hard:
            // Settings OxygenScale
            timeIntervalOxygenScale = 10
            
            // Settings Fish
            timeDurationFish = 6
            timeDelayFish = 0
            timerIntervalFish = timeDurationFish + timeDelayFish
            
            // Settings Ship
            timeDurationShip = 6
            timeDelayShip = 0
            timerIntervalShip = timeDurationShip + timeDelayShip
            
            // Settings BottomObstacles
            timeDurationBottomObstacles = 10
            timeDelayBottomObstacles = 0
            timerIntervalBottomObstacles = timeDurationBottomObstacles + timeDelayBottomObstacles
            
            // other
            difficultyPoints = 150
        }
    }
}
    
