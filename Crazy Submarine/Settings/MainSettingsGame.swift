import Foundation

class MainSettingsGame: Codable {
    var indexSubmarine: Int //= 0
    var difficultyGame: Difficulty //= .normal
    var name: String //= "Player"
    let flagSelectedDifficulty: Bool = true
        
    init(indexSubmarine: Int = 0, DifficultyGame: Difficulty = .normal, name: String = "Player") {
        self.indexSubmarine = indexSubmarine
        self.difficultyGame = DifficultyGame
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey { // CodingKeys: String, CodingKey - обязательное требование для работы с протоколом codable
        case indexSubmarine, difficultyGame, name
    }
    
    required public init(from decoder: Decoder) throws { // это конструктор которы собирает из упакованного объекта
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.indexSubmarine = try container.decode(Int.self, forKey: .indexSubmarine) // container достань(decode) строку(String.self) по ключу .name
        self.difficultyGame = try container.decode(Difficulty.self, forKey: .difficultyGame)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws { // это упаковщик, throws - этот метод может крашнуться, поэтому необходимо оборачивать его в DO / Catch
        var container = encoder.container(keyedBy: CodingKeys.self) // в данном  случае container это коробка в которую мы складываем все наши property
        try container.encode(self.indexSubmarine, forKey: .indexSubmarine) // container упакуй(encode) name  с ключем name !!! Упаковка-это превращение нашего объекта в Data - чтобы в дальнейшем записать это в UserDefaults или FileManager
        try container.encode(self.difficultyGame, forKey: .difficultyGame)
        try container.encode(self.name, forKey: .name)
    }
    
    
}




