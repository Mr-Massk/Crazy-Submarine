import UIKit

class GameOverViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var offButton: UIButton!
    @IBOutlet weak var rebootButton: UIButton!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var mainWallpaper: UIImageView!
    
    // MARK: - let/var
    var crashSubmarineImageView = UIImageView()
    var screenHeight: CGFloat = 0
    var screenWidth: CGFloat = 0
    var totalScore = 0

    // MARK: - lifecicle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        labelsSetting()
        addCrashSubmarine()
        self.view.sendSubviewToBack(mainWallpaper)
//        print("You score: \(totalScore)")
    }
    
     // MARK: - ABActions
    @IBAction func offButtonPressed(_ sender: UIButton) {
        exit(-1)
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func rebootButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - flow funcs
    func labelsSetting() {
        let fontLabelGameOver = UIFont(name: "Rockwell-Bold", size: 50)
        self.gameOverLabel.font = fontLabelGameOver
        self.gameOverLabel.dropShadow()
        textOptions()
        self.totalScoreLabel.dropShadow()
        
        func textOptions() {
               // шаблон с атрибутами/настройками текста
               let attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor.systemGreen, // цвет шрифта
//                   NSAttributedString.Key.backgroundColor: UIColor.yellow, // цвет выделения текста
                   NSAttributedString.Key.underlineStyle: NSUnderlineStyle.patternDash.rawValue // стиль подчеркивания текста
               ]
            let attrString = NSMutableAttributedString(string: "You score: ", attributes: attributes) // создаем строковую константу с присвоением текста и применением атрибутов. NSMutableAttributedString прописываем для того чтобы добавить текст через append.
               
               // второй шаблон с атрибутами
               let secondAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: UIColor.systemRed, // цвет шрифта
//                   NSAttributedString.Key.backgroundColor: UIColor.gray, // цвет выделения текста
                   NSAttributedString.Key.underlineStyle: NSUnderlineStyle.patternDot.rawValue  // стиль подчеркивания текста
               ]
            let newAttrString = NSAttributedString(string: String(self.totalScore), attributes: secondAttributes)
               attrString.append(newAttrString) // добавление второй части текста к первой
               let firstFont = UIFont(name: "Rockwell-Bold", size: 25) // выбор шрифта и его размера
            self.totalScoreLabel.font = firstFont // присвоить шрифт
               self.totalScoreLabel.attributedText = attrString // присвоить текст с атрибутами
            
           }
    }
    
    func addCrashSubmarine() {
        let crashSubmarineImage = UIImage(named: "crashSubmarineFire")
        self.crashSubmarineImageView.image = crashSubmarineImage
        self.crashSubmarineImageView.frame.origin.x = self.screenWidth / 2 - self.crashSubmarineImageView.frame.width / 2
        self.crashSubmarineImageView.frame.origin.y = self.screenHeight * 0.6
        self.view.addSubview(self.crashSubmarineImageView)
    }
    
}
