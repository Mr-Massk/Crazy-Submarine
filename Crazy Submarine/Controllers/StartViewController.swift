import UIKit
class StartViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var optionsButton: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mainWallpaper: UIImageView!
    
    // MARK: - let/var


    
    // MARK: - lifecicle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.sendSubviewToBack(mainWallpaper)
        startButton.dropShadow()
        optionsButton.dropShadow()
        let settingsRecognizer = UITapGestureRecognizer(target: self, action: #selector(getSettingsScreen))
        self.optionsButton.addGestureRecognizer(settingsRecognizer)
    }

    
    // MARK: - IBActions
    @IBAction func startButtonPressed(_ sender: UIButton) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
               
    }
    
    @IBAction func getSettingsScreen() {        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - flow funcs   
    
}

