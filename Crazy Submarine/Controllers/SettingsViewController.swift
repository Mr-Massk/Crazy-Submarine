import UIKit

class SettingsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var submarineImageView: UIImageView!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    // MARK: - let/var
    static let multicolorSubmarineArray = ["submarine", "aquaSubmarine", "blueSubmarine", "greenSubmarine", "pinkSubmarine", "purpleSubmarine", "redSubmarine", "yellowSubmarine" ]
    var submarineImage = UIImage()
    var indexSubmarine = 0
    var settings = MainSettingsGame()
    
    // MARK: - lifecicle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSaveSettings()
        loadName()
        getIndexSubmarine()
        showImageSubmarine()
        let choiceImageSubmarineRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectionColorSubmarineButtonPressed))
        self.submarineImageView.addGestureRecognizer(choiceImageSubmarineRecognizer)
    }
    
    // MARK: - IBActions
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func applyButtonPressed(_ sender: UIButton) {
        if let namePlayer = nameTextField.text {
            if namePlayer.isEmpty {
                alertEmptyName()
            } else {
                self.settings.name = namePlayer
                saveSettings()
            }
        }
    }
    
    @IBAction func easyButtonPressed(_ sender: UIButton) {
        self.settings.difficultyGame = .easy
        colorButtonSelection(colorButton: .easy)
        saveSettings()
    }
    
    @IBAction func normalButtonPressed(_ sender: UIButton) {
        self.settings.difficultyGame = .normal
        colorButtonSelection(colorButton: .normal)
        saveSettings()
    }
    
    @IBAction func hardButtonPressed(_ sender: UIButton) {
        self.settings.difficultyGame = .hard
        colorButtonSelection(colorButton: .hard)
        saveSettings()
    }
    
    @IBAction func selectionColorSubmarineButtonPressed() {
        let numbersImages = SettingsViewController.multicolorSubmarineArray.count
        if indexSubmarine < numbersImages - 1 {
            indexSubmarine += 1
        } else {
            indexSubmarine = 0
        }
        showImageSubmarine()
        self.settings.indexSubmarine = self.indexSubmarine
        saveSettings()
    }
    
    // MARK: - flow funcs
    func loadSaveSettings() {
        guard let mainSettings = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else { return }
        self.settings = mainSettings
        colorButtonSelection(colorButton: mainSettings.difficultyGame)
    }
    
    func loadName() {
        guard let mainSettings = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else { return }
        self.nameTextField.text = mainSettings.name
    }
    
    func saveSettings() {
        UserDefaults.standard.set(encodable: settings, forKey: "mainSettingsGame")
    }
    
    func getIndexSubmarine() {
        guard let mainSettings = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else { return }
        //        guard let mainSettings = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else { return }
        self.indexSubmarine = mainSettings.indexSubmarine
    }
    
    func showImageSubmarine() {
        if let image = UIImage(named: SettingsViewController.multicolorSubmarineArray[indexSubmarine]) {
            submarineImage = image
        }
        self.submarineImageView.image = submarineImage
    }
    
    func colorButtonSelection(colorButton: Difficulty) {
        switch colorButton {
        case .easy:
            defaultsColorsButtonsDifficulty()
            self.easyButton.backgroundColor = .systemGreen
            
        case .normal:
            defaultsColorsButtonsDifficulty()
            self.normalButton.backgroundColor = .systemYellow
            
        case .hard:
            defaultsColorsButtonsDifficulty()
            self.hardButton.backgroundColor = .systemRed
        }
        
        func defaultsColorsButtonsDifficulty() {
            self.easyButton.backgroundColor = .systemGray4
            self.normalButton.backgroundColor = .systemGray4
            self.hardButton.backgroundColor = .systemGray4
        }
    }
    
    func alertEmptyName() {
        let alert = UIAlertController(title: "Warning", message: "Name field is empty...", preferredStyle: .alert) // Создание алерта, задаем заголовок и текст сообщения
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in // создание кнопки "ОК"
        }
        
        alert.addAction(okAction) // добавление кнопки "ОК" в алерт
        present(alert, animated: true)
        
    }
    
}
