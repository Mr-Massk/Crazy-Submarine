import UIKit
final class StartViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var optionsButton: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var mainWallpaper: UIImageView!
    
    // MARK: - let/var
    static let identifier = "StartViewController"
    
    // MARK: - lifecicle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGestures()
    }

    
    // MARK: - IBActions
    @IBAction func startButtonPressed(_ sender: UIButton) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: GameViewController.identifier) as? GameViewController else { return }
        navigationController?.pushViewController(controller, animated: true)
               
    }
    
    @IBAction func getSettingsScreen() {        
        guard let controller = storyboard?.instantiateViewController(withIdentifier: SettingsViewController.identifier) as? SettingsViewController else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - flow funcs
    private func setupView() {
        startButton.dropShadow()
        optionsButton.dropShadow()
    }
    
    private func setupGestures() {
        let settingsRecognizer = UITapGestureRecognizer(target: self, action: #selector(getSettingsScreen))
        self.optionsButton.addGestureRecognizer(settingsRecognizer)
    }
    
}

