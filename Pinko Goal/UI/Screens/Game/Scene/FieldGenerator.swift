import SpriteKit

enum GoalPosition {
    case top, right, bottom, left
    
    static func random() -> GoalPosition {
        let a: [GoalPosition] = [.top, .right, .bottom, .left]
        return a.randomElement() ?? .top
    }
}

class FieldGenerator {
    
    static func generateField(to scene: SKScene) -> GoalPosition {
        let position: GoalPosition = GoalPosition.random()
        
        if position == .top {
            let topFirstNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 300, height: 20))
            let topSecondNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 900, height: 20))
            topFirstNode.position = CGPoint(x: 200, y: scene.size.height - 600)
            topSecondNode.position = CGPoint(x: 1350, y: scene.size.height - 600)
            
            setPBToNode(to: topFirstNode)
            setPBToNode(to: topSecondNode)
            
            scene.addChild(topFirstNode)
            scene.addChild(topSecondNode)
            
            let leftNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 2100))
            leftNode.position = CGPoint(x: 50, y: scene.size.height / 2 - 20)
            setPBToNode(to: leftNode)
            scene.addChild(leftNode)
            
            let rightNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 2100))
            rightNode.position = CGPoint(x: scene.size.width - 50, y: scene.size.height / 2 - 20)
            setPBToNode(to: rightNode)
            scene.addChild(rightNode)
            
            let bottomNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 1750, height: 20))
            bottomNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2 - 1070)
            setPBToNode(to: bottomNode)
            scene.addChild(bottomNode)
            
            let goalInvisible = SKSpriteNode(color: .clear, size: CGSize(width: 500, height: 10))
            goalInvisible.position = CGPoint(x: 620, y: scene.size.height - 600)
            setPBToNode(to: goalInvisible, category: 3)
            scene.addChild(goalInvisible)
            
            let starNode = SKSpriteNode(imageNamed: "star")
            setPBToNode(to: starNode, category: 4)
            starNode.size = CGSize(width: 100, height: 80)
            starNode.position = CGPoint(x: 620, y: scene.size.height - 700)
            scene.addChild(starNode)
        } else if position == .right {
            let topFirstNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 1750, height: 20))
            topFirstNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height - 600)
            setPBToNode(to: topFirstNode)
            scene.addChild(topFirstNode)
            
            let leftNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 2100))
            leftNode.position = CGPoint(x: 50, y: scene.size.height / 2 - 20)
            setPBToNode(to: leftNode)
            scene.addChild(leftNode)
            
            let rightFirstNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 800))
            rightFirstNode.position = CGPoint(x: scene.size.width - 50, y: scene.size.height / 2 + 635)
            let rightSecondNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 800))
            rightSecondNode.position = CGPoint(x: scene.size.width - 50, y: scene.size.height / 2 - 680)
            setPBToNode(to: rightFirstNode)
            setPBToNode(to: rightSecondNode)
            scene.addChild(rightFirstNode)
            scene.addChild(rightSecondNode)
            
            let bottomNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 1750, height: 20))
            bottomNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2 - 1070)
            setPBToNode(to: bottomNode)
            scene.addChild(bottomNode)
            
            let goalInvisible = SKSpriteNode(color: .clear, size: CGSize(width: 10, height: 500))
            goalInvisible.position = CGPoint(x: scene.size.width - 50, y: scene.size.height / 2)
            setPBToNode(to: goalInvisible, category: 3)
            scene.addChild(goalInvisible)
            
            let starNode = SKSpriteNode(imageNamed: "star")
            setPBToNode(to: starNode, category: 4)
            starNode.size = CGSize(width: 100, height: 80)
            starNode.position = CGPoint(x: scene.size.width - 150, y: scene.size.height / 2)
            scene.addChild(starNode)
        } else if position == .left {
            let topFirstNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 1750, height: 20))
            topFirstNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height - 600)
            setPBToNode(to: topFirstNode)
            scene.addChild(topFirstNode)
            
            let leftFirstNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 800))
            leftFirstNode.position = CGPoint(x: 50, y: scene.size.height / 2 + 635)
            let leftSecondNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 800))
            leftSecondNode.position = CGPoint(x: 50, y: scene.size.height / 2 - 680)
            setPBToNode(to: leftFirstNode)
            setPBToNode(to: leftSecondNode)
            scene.addChild(leftFirstNode)
            scene.addChild(leftSecondNode)
        
            let rightNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 2100))
            rightNode.position = CGPoint(x: scene.size.width - 50, y: scene.size.height / 2 - 20)
            setPBToNode(to: rightNode)
            scene.addChild(rightNode)
            
            let bottomNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 1750, height: 20))
            bottomNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2 - 1070)
            setPBToNode(to: bottomNode)
            scene.addChild(bottomNode)
            
            let goalInvisible = SKSpriteNode(color: .clear, size: CGSize(width: 10, height: 500))
            goalInvisible.position = CGPoint(x: 50, y: scene.size.height / 2)
            setPBToNode(to: goalInvisible, category: 3)
            scene.addChild(goalInvisible)
            
            let starNode = SKSpriteNode(imageNamed: "star")
            setPBToNode(to: starNode, category: 4)
            starNode.size = CGSize(width: 100, height: 80)
            starNode.position = CGPoint(x: 150, y: scene.size.height / 2)
            scene.addChild(starNode)
        } else if position == .bottom {
            let topFirstNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 1750, height: 20))
            topFirstNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height - 600)
            setPBToNode(to: topFirstNode)
            scene.addChild(topFirstNode)
            
            let leftNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 2100))
            leftNode.position = CGPoint(x: 50, y: scene.size.height / 2 - 20)
            setPBToNode(to: leftNode)
            scene.addChild(leftNode)
            
            let rightNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 20, height: 2100))
            rightNode.position = CGPoint(x: scene.size.width - 50, y: scene.size.height / 2 - 20)
            setPBToNode(to: rightNode)
            scene.addChild(rightNode)
            
            let bottomFirstNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 300, height: 20))
            let bottomSecondNode = SKSpriteNode(color: UIColor.init(red: 11/255, green: 56/255, blue: 172/255, alpha: 1), size: CGSize(width: 900, height: 20))
            bottomFirstNode.position = CGPoint(x: 200, y: scene.size.height / 2 - 1070)
            bottomSecondNode.position = CGPoint(x: 1350, y: scene.size.height / 2 - 1070)
            
            setPBToNode(to: bottomFirstNode)
            setPBToNode(to: bottomSecondNode)
            
            scene.addChild(bottomFirstNode)
            scene.addChild(bottomSecondNode)
            
            let goalInvisible = SKSpriteNode(color: .clear, size: CGSize(width: 500, height: 10))
            goalInvisible.position = CGPoint(x: 620, y: scene.size.height / 2 - 1070)
            setPBToNode(to: goalInvisible, category: 3)
            scene.addChild(goalInvisible)
            
            let starNode = SKSpriteNode(imageNamed: "star")
            setPBToNode(to: starNode, category: 4)
            starNode.size = CGSize(width: 100, height: 80)
            starNode.position = CGPoint(x: 620, y: scene.size.height / 2 - 1000)
            scene.addChild(starNode)
        }
        
        return position
    }
    
    private static func setPBToNode(to node: SKSpriteNode, category: UInt32 = 2) {
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.categoryBitMask = category
        node.physicsBody?.collisionBitMask = 1
        node.physicsBody?.contactTestBitMask = 1
    }
    
}
