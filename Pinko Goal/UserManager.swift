import Foundation

class UserManager: ObservableObject {
    
    @Published var stars = UserDefaults.standard.integer(forKey: "stars") {
        didSet {
            UserDefaults.standard.set(stars, forKey: "stars")
        }
    }
    
}
