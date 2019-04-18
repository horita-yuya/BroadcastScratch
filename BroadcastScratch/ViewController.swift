import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var videoCastButton: UIButton!
    @IBOutlet private weak var haishinKitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension ViewController {
    func configure() {
        videoCastButton.addTarget(self, action: #selector(moveToVideoCast), for: .touchUpInside)
        haishinKitButton.addTarget(self, action: #selector(moveToHaishinKit), for: .touchUpInside)
    }
    
    @objc func moveToVideoCast() {
        let viewController = UINib(nibName: "VideoCastViewController", bundle: nil).instantiate(withOwner: nil).first as! VideoCastViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func moveToHaishinKit() {
        let viewController = UINib(nibName: "HaishinKitViewController", bundle: nil).instantiate(withOwner: nil).first as! HaishinKitViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
