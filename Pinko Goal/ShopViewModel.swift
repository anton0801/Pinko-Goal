import Foundation

class ShopViewModel: ObservableObject {
    @Published var availableBalls: [BallItem]
    @Published var purchasedBalls: [BallItem]
    @Published var currentBall: BallItem?
    
    private let userDefaults = UserDefaults.standard
    private let purchasedBallsKey = "purchasedBalls"
    private let currentBallKey = "currentBall"

    init() {
        let availableBalls = [
            BallItem(id: UUID(), ballSrc: "ball", price: 0),
            BallItem(id: UUID(), ballSrc: "ball_2", price: 30),
            BallItem(id: UUID(), ballSrc: "ball_3", price: 50),
            BallItem(id: UUID(), ballSrc: "ball_4", price: 70),
            BallItem(id: UUID(), ballSrc: "ball_5", price: 90),
            BallItem(id: UUID(), ballSrc: "ball_6", price: 110),
            BallItem(id: UUID(), ballSrc: "ball_7", price: 130),
            BallItem(id: UUID(), ballSrc: "ball_8", price: 150),
            BallItem(id: UUID(), ballSrc: "ball_9", price: 170)
        ]
        
        self.availableBalls = availableBalls
        
        if let savedBallsData = userDefaults.data(forKey: purchasedBallsKey),
           let decodedBalls = try? JSONDecoder().decode([BallItem].self, from: savedBallsData) {
            self.purchasedBalls = decodedBalls
        } else {
            self.purchasedBalls = []
        }
        
        // Load current ball from UserDefaults
        if let savedBallData = userDefaults.data(forKey: currentBallKey),
           let decodedBall = try? JSONDecoder().decode(BallItem.self, from: savedBallData) {
            self.currentBall = decodedBall
        } else {
            self.currentBall = nil
        }
        
        if purchasedBalls.isEmpty {
            purchaseBall(ball: availableBalls[0])
            selectBall(ball: availableBalls[0])
        }
    }

    // Method to purchase a ball
    func purchaseBall(ball: BallItem) {
        if !purchasedBalls.contains(where: { $0.id == ball.id }) && availableBalls.contains(where: { $0.id == ball.id }) {
            purchasedBalls.append(ball)
            savePurchasedBalls()
        }
    }

    // Method to check if a ball is purchased
    func isBallPurchased(ball: BallItem) -> Bool {
        return purchasedBalls.contains(where: { $0.id == ball.id })
    }

    // Method to set the currently selected ball
    func selectBall(ball: BallItem) {
        if isBallPurchased(ball: ball) {
            currentBall = ball
            saveCurrentBall()
        }
    }

    // Save purchased balls to UserDefaults
    private func savePurchasedBalls() {
        if let encodedBalls = try? JSONEncoder().encode(purchasedBalls) {
            userDefaults.set(encodedBalls, forKey: purchasedBallsKey)
        }
    }

    // Save current ball to UserDefaults
    private func saveCurrentBall() {
        if let encodedBall = try? JSONEncoder().encode(currentBall) {
            userDefaults.set(encodedBall, forKey: currentBallKey)
        }
    }
}


struct BallItem: Identifiable, Codable {
    var id = UUID()             // Unique identifier for each ball item
    var ballSrc: String         // Source or name of the ball image/resource
    var price: Int              // Price of the ball
}
