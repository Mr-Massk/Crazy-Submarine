import Foundation

final class MainSettingsGame: Codable {
    var indexSubmarine: Int
    var difficultyGame: Difficulty
    var name: String
        
    init(indexSubmarine: Int = 0, DifficultyGame: Difficulty = .normal, name: String = "Player") {
        self.indexSubmarine = indexSubmarine
        self.difficultyGame = DifficultyGame
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case indexSubmarine, difficultyGame, name
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.indexSubmarine = try container.decode(Int.self, forKey: .indexSubmarine)
        self.difficultyGame = try container.decode(Difficulty.self, forKey: .difficultyGame)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.indexSubmarine, forKey: .indexSubmarine)
        try container.encode(self.difficultyGame, forKey: .difficultyGame)
        try container.encode(self.name, forKey: .name)
    }
    
    
}




