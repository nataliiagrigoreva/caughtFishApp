import UIKit

class ViewController: UIViewController {
    
    var fishViews: [UIImageView] = []
    var caughtFishCount = 0
    
    lazy var fish: UIImageView = {
        let image = UIImage(named: "fish")
        let view = UIImageView(image: image)
        view.frame = CGRect( x: 0, y: 0, width: 200, height: 200)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var caughtFishLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 16, y: view.frame.height - 60, width: 200, height: 50))
        label.text = "Поймано: \(caughtFishCount)"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        view.addSubview(fish)
        view.addSubview(caughtFishLabel)
        moveLeft()
        moveRight()
        moveTop()
        moveBottom()
        
        for _ in 1..<5 {
            let image = UIImage(named: "fish")
            let view = UIImageView(image: image)
            let x = CGFloat.random(in: 0...(self.view.frame.width - 200))
            let y = CGFloat.random(in: 0...(self.view.frame.height - 200))
            view.frame = CGRect(x: x, y: y, width: 200, height: 200)
            view.contentMode = .scaleAspectFit
            self.view.addSubview(view)
            fishViews.append(view)
        }
        
        for fishView in fishViews {
            moveFish(fishView: fishView)
        }
    }
    func moveFish(fishView: UIImageView) {
        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            fishView.center = CGPoint(x: CGFloat.random(in: 0...(self.view.frame.width)), y: CGFloat.random(in: 0...(self.view.frame.height)))
        },
                       completion: { finished in
            self.moveFish(fishView: fishView)
        })
    }
    
    func moveLeft() {
        
        
        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            self.fish.center = CGPoint(x: 150, y: 400)
        },
                       completion: { finished in
            print("fish moved left!")
            self.moveRight()
        })
    }
    
    
    func moveRight() {
        
        
        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            self.fish.center = CGPoint(x: self.view.frame.width - 150, y: 400)
        },
                       completion: { finished in
            print("fish moved right!")
            self.moveLeft()
        })
    }
    
    func moveTop() {
        
        
        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            self.fish.center = CGPoint(x: 150, y: 200)
        },
                       completion: { finished in
            print("fish moved top!")
            self.moveBottom()
        })
    }
    
    
    func moveBottom() {
        
        
        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            self.fish.center = CGPoint(x: 150, y: self.view.frame.height - 200)
        },
                       completion: { finished in
            print("fish moved bottom!")
            self.moveTop()
        })
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        for fishView in fishViews {
            let tapLocation = gesture.location(in: fishView.superview)
            if (fishView.layer.presentation()?.frame.contains(tapLocation))! {
                print("fish tapped!")
                fishView.layer.removeAllAnimations()
                fishView.removeFromSuperview()
                caughtFishCount += 1
                caughtFishLabel.text = "Поймано: \(caughtFishCount)"
                
                if caughtFishCount == 5 {
                    resetFish()
                }
            }
        }
    }
    
    func resetFish() {
        fishViews.forEach { $0.removeFromSuperview() }
        fishViews.removeAll()
        caughtFishCount = 0
        caughtFishLabel.text = "Поймано: \(caughtFishCount)"
        for _ in 1..<5 {
            let image = UIImage(named: "fish")
            let view = UIImageView(image: image)
            let x = CGFloat.random(in: 0...(self.view.frame.width - 200))
            let y = CGFloat.random(in: 0...(self.view.frame.height - 200))
            view.frame = CGRect(x: x, y: y, width: 200, height: 200)
            view.contentMode = .scaleAspectFit
            self.view.addSubview(view)
            fishViews.append(view)
        }
        
        for fishView in fishViews {
            moveFish(fishView: fishView)
        }
    }
    
    func fishCatchedAnimation() {
    }
}
