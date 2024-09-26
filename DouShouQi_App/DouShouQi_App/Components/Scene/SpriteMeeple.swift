//
//  SpriteMeeple.swift
//  DouShouQi_App
//
//  Created by Nathan Verdier on 27/05/2024.
//

import Foundation
import SpriteKit

class SpriteMeeple : SKNode {
    
    static let offset = CGPoint(x: -300, y: 400)
    static let direction = CGVector(dx: 100, dy: -100)
    
    let imageNode : SKSpriteNode
    var ellipseNode : SKShapeNode
    
    var originalSize: CGSize
    var originalEllipseSize: CGSize
    
    var onMove: ((SpriteMeeple, CGPoint, CGPoint) -> ())?
    
    var cellPosition: CGPoint{
        didSet(cellPosition){
            self.position.x = SpriteMeeple.offset.x + SpriteMeeple.direction.dx*cellPosition.x
            self.position.y = SpriteMeeple.offset.y + SpriteMeeple.direction.dy*cellPosition.y
        }
    }
    
    private var oldCellPosition: CGPoint?
    
    func getCellPosition() -> CGPoint {
        return CGPoint(x: Int((self.position.x - SpriteMeeple.offset.x)/SpriteMeeple.direction.dx), y: Int((self.position.y - SpriteMeeple.offset.y)/SpriteMeeple.direction.dy))
    }
    
    init(imageNamed imageName: String, size: CGSize, backgroundColor: UIColor, imageRotation : Double = 0){
        imageNode = SKSpriteNode(imageNamed: imageName)
        originalSize = CGSize(width: 80, height: 65)
        imageNode.size = originalSize
        
        
        originalEllipseSize = CGSize(width: 90, height: 90)
        ellipseNode = SKShapeNode(ellipseOf: originalEllipseSize)
        ellipseNode.fillColor = backgroundColor
        
        cellPosition = CGPoint(x: 0, y: 0)
        
        super.init()
        
        let radians = CGFloat(imageRotation * Double.pi / 180.0)
        imageNode.zRotation = radians
        
        //ellipseNode = SKShapeNode(ellipseOf: CGSize(width: imageNode.size.width, height: imageNode.size.height))
        self.addChild(ellipseNode)
        self.addChild(imageNode)
    }
    
    required init?(coder aDecoder:NSCoder){
        imageNode = SKSpriteNode(imageNamed: "rat")
        ellipseNode = SKShapeNode(ellipseOf: CGSize(width: 0, height: 0))
        cellPosition = CGPoint(x: 0, y: 0)
        originalSize = CGSize(width: 0, height: 0)
        originalEllipseSize = CGSize(width: 0, height: 0)
        super.init(coder: aDecoder)
    }
    
    public func setOnMove(onMove: @escaping (SpriteMeeple, CGPoint, CGPoint) -> ()) { self.onMove = onMove }
                                   
    override var isUserInteractionEnabled: Bool{
        set { }
        get { true }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.oldCellPosition = getCellPosition()
        
        imageNode.size = CGSize(width: imageNode.size.width * 1.1, height: imageNode.size.height * 1.1)
        ellipseNode.path = SKShapeNode(ellipseOf: CGSize(width: originalEllipseSize.width*1.1, height: originalEllipseSize.height*1.1)).path
        self.zPosition = 1
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let parent = parent, let position = touches.first?.location(in: parent) {
            // Arrondir à la case la plus proche pour x et y
            let x = round(position.x / 100) * 100
            let y = round(position.y / 100) * 100

            // Assurer que les coordonnées sont dans les limites
            let clampedX = min(max(x, -300), 300)
            let clampedY = min(max(y, -400), 400)

            self.position = CGPoint(x: clampedX, y: clampedY)
        }

        imageNode.size = originalSize
        ellipseNode.path = SKShapeNode(ellipseOf: originalEllipseSize).path
        
        if let onMove: (SpriteMeeple, CGPoint, CGPoint) -> () = onMove {
            onMove(self, self.oldCellPosition!, self.getCellPosition())
        }

        self.zPosition = 0
    }
    
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
            self.position = touches.first?.location(in: parent!) ?? CGPoint(x: 0, y: 0)
    }
}
