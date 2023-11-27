import UIKit
import Foundation

extension UIView {    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 10
    }
}
    
    extension UIColor {
        static var colorRandom: UIColor {           
            let r:CGFloat  = .random(in: 0...1)
            let g:CGFloat  = .random(in: 0...1)
            let b:CGFloat  = .random(in: 0...1)
            return UIColor(red: r, green: g, blue: b, alpha: 1)
        }
}

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String)  {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

