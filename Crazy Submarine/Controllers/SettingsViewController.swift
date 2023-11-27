import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var submarineImageView: UIImageView!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    // MARK: - let/var
    static let identifier = "SettingsViewController"
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
        setupGestures()
    }
    
    // MARK: - IBActions
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func applyButtonPressed(_ sender: UIButton) {
        guard let playerName = nameTextField.text else { return }
        
            if playerName.isEmpty {
                alertEmptyName()
            } else {
                settings.name = playerName
                saveSettings()
            }
        
    }
    
    @IBAction func easyButtonPressed(_ sender: UIButton) {
        settings.difficultyGame = .easy
        colorButtonSelection(colorButton: .easy)
        saveSettings()
    }
    
    @IBAction func normalButtonPressed(_ sender: UIButton) {
        settings.difficultyGame = .normal
        colorButtonSelection(colorButton: .normal)
        saveSettings()
    }
    
    @IBAction func hardButtonPressed(_ sender: UIButton) {
        settings.difficultyGame = .hard
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
        settings.indexSubmarine = indexSubmarine
        saveSettings()
    }
    
    // MARK: - flow funcs
    private func setupGestures() {
        let choiceImageSubmarineRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectionColorSubmarineButtonPressed))
        submarineImageView.addGestureRecognizer(choiceImageSubmarineRecognizer)
    }
    
    func loadSaveSettings() {
        guard let mainSettings = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else { return }
        settings = mainSettings
        colorButtonSelection(colorButton: mainSettings.difficultyGame)
    }
    
    func loadName() {
        guard let mainSettings = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else { return }
        nameTextField.text = mainSettings.name
    }
    
    func saveSettings() {
        UserDefaults.standard.set(encodable: settings, forKey: "mainSettingsGame")
    }
    
    func getIndexSubmarine() {
        guard let mainSettings = UserDefaults.standard.value(MainSettingsGame.self, forKey: "mainSettingsGame") else { return }
        indexSubmarine = mainSettings.indexSubmarine
    }
    
    func showImageSubmarine() {
        if let image = UIImage(named: SettingsViewController.multicolorSubmarineArray[indexSubmarine]) {
            submarineImage = image
        }
        submarineImageView.image = submarineImage
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
            hardButton.backgroundColor = .systemRed
        }
        
        func defaultsColorsButtonsDifficulty() {
            easyButton.backgroundColor = .systemGray4
            normalButton.backgroundColor = .systemGray4
            hardButton.backgroundColor = .systemGray4
        }
    }
    
    func alertEmptyName() {
        let alert = UIAlertController(title: "Warning", message: "Name field is empty...", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
        }
        
        alert.addAction(okAction) 
        present(alert, animated: true)
        
    }
    
}
