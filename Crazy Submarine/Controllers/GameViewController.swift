var screenHeight = UIScreen.main.bounds.height
var screenWidth = UIScreen.main.bounds.width

enum Direction {
    case up
    case down
}

import UIKit
class GameViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var ascentButton:UIButton!
    @IBOutlet weak var diveButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameMenuButton: UIImageView!
    
    // MARK: - let/var
    
    // submarine settings
    let submarineImageView = UIImageView()
    var indexSubmarine = 0
    let submarineHeight = screenHeight * 0.15
    let submarineWidth = screenWidth * 0.19
    let positionXSubmarine = screenWidth * 0.1
    let positionYSubmarine = CGFloat.random(in: screenHeight * 0.3...screenHeight - screenHeight * 0.15)
    
    // oxygenScale
    let oxygenScale = UIImageView()
    
    // fishs
    let fishImageView = UIImageView()
    var timerFish = Timer()
    
    // ship
    let shipImageView = UIImageView()
    var timerShip = Timer()
    
    // bottom obstacles
    let obstaclesImageView = UIImageView()
    var timerBottomObstacles = Timer()
    
    // score
    var timerScoreLabel = Timer()
    var totalScore = 0
    
    // others
    var timerOxygenScale = Timer()
    let upperBound = screenHeight * 0.2
    var timerIntersect = Timer()
    var submarineInWater = true
    var difficulty = SettingsDifficultyGame(difficulty: .normal)
    
    // MARK: - lifecicle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        // funcs
        selectDifficultyGame()
        checkIntersect()
        createSubmarine()
        createFish()
        createShip()
        createBottomObstacles()
        scoring()
        addOxygenScale()
        
        // recognizers
        let upMotionRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapUpMotionDetected))
        let downMotionRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapDownMotionDetected))
        let gameMenuRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGameMenuDetected))
        self.ascentButton.addGestureRecognizer(upMotionRecognizer)
        self.diveButton.addGestureRecognizer(downMotionRecognizer)
        self.gameMenuButton.addGestureRecognizer(gameMenuRecognizer)
        
        //
        self.view.bringSubviewToFront(ascentButton)
        self.view.bringSubviewToFront(diveButton)
        self.view.bringSubviewToFront(diveButton)
    }
    
    // MARK: - IBActions
    @IBAction func tapUpMotionDetected() {
        self.move(direction: .up)
        
        if submarineImageView.frame.origin.y <= upperBound + 2 && submarineInWater  {
            self.timerOxygenScale.invalidate()
            self.oxygenScale.layer.removeAllAnimations()
            submarineInWater = false
            addOxygenScale()
        }
    }
    
    @IBAction func tapDownMotionDetected() {
        self.move(direction: .down)
        if submarineInWater == false {
            addOxygenScale()
            addAnimationOxygenScale()
            submarineInWater = true
        }
    }
    
    @IBAction func tapGameMenuDetected() {
        
    }
    
    // MARK: - flow funcs
    func selectDifficultyGame() {
            guard let difficulty = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else {return}
            self.difficulty = SettingsDifficultyGame(difficulty: difficulty.difficultyGame)
    }
    
    func createSubmarine() {
        getIndexSubmarine()
        print(self.indexSubmarine)
        let submarineImage = UIImage(named: SettingsViewController.multicolorSubmarineArray[self.indexSubmarine])
        self.submarineImageView.image = submarineImage
        self.submarineImageView.frame = CGRect(x: positionXSubmarine, y: positionYSubmarine, width: submarineWidth, height: submarineHeight)
        self.view.addSubview(self.submarineImageView)
        func getIndexSubmarine() {
            guard let mainSetting = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else { return }
            self.indexSubmarine = mainSetting.indexSubmarine
        }
    }
    
    func addOxygenScale() {
        let positionYSubmarine = self.submarineImageView.frame.origin.y
        let positionXSubmarine = self.submarineImageView.frame.origin.x
        
        oxygenScale.frame = CGRect(x: positionXSubmarine, y: positionYSubmarine, width: submarineWidth, height: self.submarineWidth * 0.05)
        oxygenScale.backgroundColor = .init(displayP3Red: 0.298743, green: 0.919093, blue: 0.321632, alpha: 1)
        view.addSubview(oxygenScale)
        if submarineInWater {
            addAnimationOxygenScale()
        }
    }
    
    func addAnimationOxygenScale() {
        UIView.animate(withDuration: difficulty.timeIntervalOxygenScale, delay: 0, options: .curveLinear) {
            let positionYSubmarine = self.submarineImageView.frame.origin.y
            let positionXSubmarine = self.submarineImageView.frame.origin.x
            self.oxygenScale.frame = CGRect(x: positionXSubmarine, y: positionYSubmarine, width: 0, height: self.submarineWidth * 0.05)
        }
        self.timerOxygenScale = Timer.scheduledTimer(withTimeInterval: difficulty.timeIntervalOxygenScale, repeats: true, block: { _ in
            self.gameOver()            
        })
    }
    
    func createFish() {
        let heightFish = screenHeight * 0.1
        let widthFish = screenWidth * 0.1
        let fishImage = UIImage(named: "crazyFish")
        self.fishImageView.image = fishImage
        //        self.fishImageView.backgroundColor = .blue //***
        self.view.addSubview(fishImageView)
        
        self.timerFish = Timer.scheduledTimer(withTimeInterval: difficulty.timerIntervalFish, repeats: true, block: { _ in
            self.fishImageView.frame = CGRect(x: screenWidth + widthFish, y: CGFloat.random(in: screenHeight * 0.3...screenHeight * 0.9), width: widthFish, height: heightFish)
            UIView.animate(withDuration: self.difficulty.timeDurationFish, delay: self.difficulty.timeDelayFish, options: .curveLinear) {
                self.fishImageView.frame.origin.x -= screenWidth + widthFish * 2
                self.fishImageView.frame.origin.y = CGFloat.random(in: screenHeight * 0.3...screenHeight * 0.9)
            }
        })
        self.timerFish.fire()
    }
    
    func createShip() {
        let heightShip = screenHeight * 0.25
        let widthShip = screenWidth * 0.27
        let shipImage = UIImage(named: "destroyer")
        self.shipImageView.image = shipImage
        self.view.addSubview(shipImageView)
//                self.shipImageView.backgroundColor = .blue
        self.timerShip = Timer.scheduledTimer(withTimeInterval: difficulty.timerIntervalShip, repeats: true, block: { _ in
            self.shipImageView.frame = CGRect(x: screenWidth, y: screenHeight * 0.01, width: widthShip, height: heightShip)
            
            UIView.animate(withDuration: self.difficulty.timeDurationShip, delay: self.difficulty.timeDelayShip, options: .curveLinear) {
                self.shipImageView.frame.origin.x -= screenWidth + widthShip
            }
        })
        self.timerShip.fire()
    }
    
    func createBottomObstacles() {
        let heightObstacles = screenHeight * 0.2
        let widthObstacles = screenWidth * 0.2
        self.view.addSubview(obstaclesImageView)
        //        self.obstaclesImageView.backgroundColor = .blue
        self.timerBottomObstacles = Timer.scheduledTimer(withTimeInterval: difficulty.timerIntervalBottomObstacles, repeats: true, block: { _ in
            let obstaclesImage = UIImage(named: randomImageObstacles())
            self.obstaclesImageView.image = obstaclesImage
            self.obstaclesImageView.frame = CGRect(x: screenWidth , y: screenHeight - heightObstacles * 0.9, width: widthObstacles, height: heightObstacles)
            UIView.animate(withDuration: self.difficulty.timeDurationBottomObstacles, delay: self.difficulty.timeDelayBottomObstacles, options: .curveLinear) {
                self.obstaclesImageView.frame.origin.x -= screenWidth + widthObstacles * 2
            }
        })
        self.timerBottomObstacles.fire()
        
        func randomImageObstacles() -> String {
            let imagesObstaclesArray: [String] = ["firstObstacles", "secondObstacles", "thirdObstacles"]
            let index = Int(arc4random_uniform(UInt32(imagesObstaclesArray.count)))
            return imagesObstaclesArray[index]
        }
    }
    
    func move(direction: Direction) {
        let positionYSubmarine = self.submarineImageView.frame.origin.y
        let shift = screenHeight * 0.038
        
        let bottomLine = screenHeight - self.submarineImageView.frame.height
        
        switch direction {
        case .up:
            let moveUp = (positionYSubmarine - shift) > upperBound ? (positionYSubmarine - shift) :  upperBound
            self.submarineImageView.frame.origin.y = moveUp
            self.oxygenScale.frame.origin.y = moveUp
            
            
            
        case .down:
            let moveDown = (positionYSubmarine + shift) < bottomLine ? (positionYSubmarine + shift) :  bottomLine
            self.submarineImageView.frame.origin.y = moveDown
            self.oxygenScale.frame.origin.y = moveDown
        }
    }
    
    func checkIntersect() {
        self.timerIntersect = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            guard let pointPositionSubmarine = self.submarineImageView.layer.presentation()?.frame else { return }
            guard let pointPositionFish = self.fishImageView.layer.presentation()?.frame else { return }
            guard let pointPositionShip = self.shipImageView.layer.presentation()?.frame else { return }
            guard let pointPositionBottomObstacles = self.obstaclesImageView.layer.presentation()?.frame else { return }
            
            if pointPositionSubmarine.intersects(pointPositionFish) || pointPositionSubmarine.intersects(pointPositionShip) || pointPositionSubmarine.intersects(pointPositionBottomObstacles){
                self.gameOver()
            }
        })
    }
    
    func scoring() {
        var counter = 0 {
            didSet {
                self.scoreLabel.text = "Score: \(counter)"
            }
        }
        self.scoreLabel.text = "Score: \(counter)"
        
        self.timerScoreLabel = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            counter += self.difficulty.difficultyPoints
            self.totalScore = counter
        })
    }
    
    func gameOver() {
        timerOxygenScale.invalidate()
        timerScoreLabel.invalidate()
        timerIntersect.invalidate()        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "GameOverViewController") as? GameOverViewController else { return }
        self.navigationController?.pushViewController(controller, animated: false)
        controller.crashSubmarineImageView = self.submarineImageView
        controller.screenHeight = screenHeight
        controller.screenWidth = screenWidth
        controller.totalScore = self.totalScore
    }
}
