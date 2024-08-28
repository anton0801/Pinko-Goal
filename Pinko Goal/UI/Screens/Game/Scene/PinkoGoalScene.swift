import SwiftUI
import SpriteKit

class PinkoGoalScene: SKScene, SKPhysicsContactDelegate {
    
    var level: Level
    
    var field: SKShapeNode!
    
    private var ball: SKSpriteNode = SKSpriteNode(imageNamed: "ball")
    private var lineArrow: SKSpriteNode = SKSpriteNode(imageNamed: "line_arrow")
    
    private var goalPosition: GoalPosition? = nil
    
    private var shieldNode: SKSpriteNode = SKSpriteNode()
    
    private var touchCountLeft = 0 {
        didSet {
            touchCountLeftLabel.text = "\(touchCountLeft)"
            if touchCountLeft == 0 {
                shieldNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.3), SKAction.removeFromParent()]))
            }
            
            if touchCountLeft < 0 {
                isPaused = true
                NotificationCenter.default.post(name: Notification.Name("game_over"), object: nil)
            }
        }
    }
    private var touchCountLeftLabel = SKLabelNode(text: "")
    
    var balanceStars = UserDefaults.standard.integer(forKey: "stars") {
        didSet {
            UserDefaults.standard.set(balanceStars, forKey: "stars")
            balanceStarsLabel.text = "\(balanceStars)"
        }
    }
    var balanceStarsLabel: SKLabelNode!
    
    init(level: Level) {
        self.level = level
        super.init(size: CGSize(width: 1850, height: 3250))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func restartGame() -> PinkoGoalScene {
        let newScene = PinkoGoalScene(level: level)
        view?.presentScene(newScene)
        return newScene
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        touchCountLeft = level.touchCount
        createBackground()
        createUI()
    }
    
    private func createBackground() {
        let node = SKSpriteNode(imageNamed: "level_background")
        node.size = size
        node.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(node)
    }
    
    private func createUI() {
        touchCountLeftLabel = .init(text: "\(touchCountLeft)")
        touchCountLeftLabel.fontName = "Recoleta"
        touchCountLeftLabel.fontSize = 500
        touchCountLeftLabel.fontColor = .black.withAlphaComponent(0.1)
        touchCountLeftLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(touchCountLeftLabel)
        
        let pauseButton = SKSpriteNode(imageNamed: "pause_btn")
        pauseButton.position = CGPoint(x: size.width - 200, y: size.height - 200)
        pauseButton.size = CGSize(width: 240, height: 200)
        pauseButton.name = "pauseButton"
        addChild(pauseButton)
        
        let balanceNode = SKSpriteNode(imageNamed: "balance")
        balanceNode.position = CGPoint(x: 250, y: size.height - 200)
        balanceNode.size = CGSize(width: 500, height: 200)
        addChild(balanceNode)
        
        balanceStarsLabel = SKLabelNode(text: "\(balanceStars)")
        balanceStarsLabel.position = CGPoint(x: 180, y: size.height - 250)
        balanceStarsLabel.fontName = "Recoleta"
        balanceStarsLabel.fontSize = 82
        balanceStarsLabel.fontColor = .white
        addChild(balanceStarsLabel)
        
        createGameField()
    }
    
    private func createGameField() {
        goalPosition = FieldGenerator.generateField(to: self)
        createBall()
        createShieldGoal()
    }
    
    private func createBall() {
        ball = SKSpriteNode(imageNamed: "ball")
        switch goalPosition {
        case .top:
            ball.position = CGPoint(x: size.width / 2, y: size.height / 2 - 700)
        case .left:
            ball.position = CGPoint(x: size.width / 2 + 500, y: size.height / 2 + 700)
        case .right:
            ball.position = CGPoint(x: size.width / 2 - 500, y: size.height / 2 + 700)
        default:
            ball.position = CGPoint(x: size.width / 2, y: size.height / 2 + 700)
        }
        
        ball.size = CGSize(width: 100, height: 100)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.collisionBitMask = 2 | 3
        ball.physicsBody?.contactTestBitMask = 2 | 3
        ball.physicsBody?.restitution = 0.9
        ball.physicsBody?.friction = 0.1
        ball.physicsBody?.linearDamping = 0.1
        ball.physicsBody?.angularDamping = 0.1
        
        lineArrow.anchorPoint = CGPoint(x: 0.5, y: 0)
        lineArrow.position = ball.position
        
        addChild(ball)
        addChild(lineArrow)
    }
    
    private func createShieldGoal() {
        switch goalPosition {
        case .top:
            shieldNode = SKSpriteNode(color: UIColor(red: 74/255, green: 14/255, blue: 96/255, alpha: 1), size: CGSize(width: 500, height: 20))
            shieldNode.position = CGPoint(x: 620, y: size.height - 600)
        case .right:
            shieldNode = SKSpriteNode(color: UIColor(red: 74/255, green: 14/255, blue: 96/255, alpha: 1), size: CGSize(width: 20, height: 500))
            shieldNode.position = CGPoint(x: size.width - 50, y: size.height / 2)
        case .left:
            shieldNode = SKSpriteNode(color: UIColor(red: 74/255, green: 14/255, blue: 96/255, alpha: 1), size: CGSize(width: 20, height: 500))
            shieldNode.position = CGPoint(x: 50, y: size.height / 2)
        default:
            shieldNode = SKSpriteNode(color: UIColor(red: 74/255, green: 14/255, blue: 96/255, alpha: 1), size: CGSize(width: 500, height: 20))
            shieldNode.position = CGPoint(x: 620, y: size.height / 2 - 1070)
        }
        
        shieldNode.physicsBody = SKPhysicsBody(rectangleOf: shieldNode.size)
        shieldNode.physicsBody?.isDynamic = false
        shieldNode.physicsBody?.affectedByGravity = false
        shieldNode.physicsBody?.categoryBitMask = 2
        shieldNode.physicsBody?.collisionBitMask = 1
        shieldNode.physicsBody?.contactTestBitMask = 1
        
        addChild(shieldNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let object = atPoint(touchLocation)
        
        if object.name == "pauseButton" {
            showPauseNode()
        }
        
        if object.name == "resume" {
            isPaused = false
            pauseNode.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.3), SKAction.removeFromParent()]))
        }
        
        if object.name == "exit" {
            NotificationCenter.default.post(name: Notification.Name("exit"), object: nil)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Вычисляем угол между центром мяча и точкой касания
        let dx = touchLocation.x - ball.position.x
        let dy = touchLocation.y - ball.position.y
        let angle = atan2(dy, dx) - .pi / 2
        
        // Поворачиваем стрелку
        // ball.zRotation = angle
        lineArrow.zRotation = angle
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let object = atPoint(touchLocation)
        
        if object.name == nil {
            // Вычисляем вектор импульса на основе направления стрелки
            let dx = touchLocation.x - ball.position.x
            let dy = touchLocation.y - ball.position.y
            let impulseMagnitude: CGFloat = 1.0
            let impulseVector = CGVector(dx: dx * impulseMagnitude, dy: dy * impulseMagnitude)
            
            // Применяем импульс к мячу
            ball.physicsBody?.applyImpulse(impulseVector)
            lineArrow.removeFromParent()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        if (contactA.categoryBitMask == 1 && contactB.categoryBitMask == 2) ||
            (contactA.categoryBitMask == 2 && contactB.categoryBitMask == 1) {
            touchCountLeft -= 1
            SKAction.playSoundFileNamed("otskok-myacha.mp3", waitForCompletion: false)
        }
        
        if (contactA.categoryBitMask == 1 && contactB.categoryBitMask == 4) ||
            (contactA.categoryBitMask == 4 && contactB.categoryBitMask == 1) {
            
            let starBody: SKPhysicsBody
            
            if contactA.categoryBitMask == 1 {
                starBody = contactB
            } else {
                starBody = contactA
            }
            
            starBody.node?.removeFromParent()
            
            balanceStars += 10
        }
        
        if (contactA.categoryBitMask == 1 && contactB.categoryBitMask == 3) ||
            (contactA.categoryBitMask == 3 && contactB.categoryBitMask == 1) {
            isPaused = true
            NotificationCenter.default.post(name: Notification.Name("game_win"), object: nil)
        }
    }
    
    private var pauseNode: SKSpriteNode!
    
    private func showPauseNode() {
        if pauseNode == nil {
            createPuuseNode()
        }
        addChild(pauseNode)
        isPaused = true
    }
    
    private func createPuuseNode() {
        pauseNode = SKSpriteNode()
        
        let pauseBackground = SKSpriteNode(imageNamed: "pause_background")
        pauseBackground.position = CGPoint(x: size.width / 2, y: size.height / 2)
        pauseBackground.size = CGSize(width: 1300, height: 1300)
        pauseNode.addChild(pauseBackground)
        
        let title = SKLabelNode(text: "Pause")
        title.fontName = "Recoleta"
        title.fontSize = 142
        title.fontColor = .white
        title.position = CGPoint(x: size.width / 2, y: size.height / 2 + 400)
        pauseNode.addChild(title)
        
        let resumeBtn = SKSpriteNode(imageNamed: "resume_btn")
        resumeBtn.position = CGPoint(x: size.width / 2, y: size.height / 2 + 100)
        resumeBtn.size = CGSize(width: 600, height: 200)
        resumeBtn.name = "resume"
        pauseNode.addChild(resumeBtn)
        
        let exitBtn = SKSpriteNode(imageNamed: "exit_btn")
        exitBtn.position = CGPoint(x: size.width / 2, y: size.height / 2 - 200)
        exitBtn.size = CGSize(width: 600, height: 200)
        exitBtn.name = "exit"
        pauseNode.addChild(exitBtn)
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: PinkoGoalScene(level: Level(id: 1, touchCount: 1)))
            .ignoresSafeArea()
    }
}
