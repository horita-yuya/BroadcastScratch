import UIKit
import VideoCast

final class VideoCastViewController: UIViewController {
    @IBOutlet private weak var preview: UIView!
    @IBOutlet private weak var connectButton: UIButton!
    @IBOutlet private weak var applyFilterButton: UIButton!
    
    private var isFiltered: Bool = false
    
    private lazy var session = VCSimpleSession(
        videoSize: view.bounds.size,
        frameRate: 30,
        bitrate: 1000000,
        videoCodecType: .h264,
        useInterfaceOrientation: false
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

private extension VideoCastViewController {
    func configure() {
        session.aspectMode = .fill
        preview.addSubview(session.previewView)
        session.previewView.frame = preview.bounds
        
        session.delegate.connectionStatusChanged = { [weak self] sessionState in
            guard let self = self else { return }
            
            switch self.session.sessionState {
            case .starting:
                self.connectButton.setTitle("Connecting", for: .normal)
                
            case .started:
                self.connectButton.setTitle("Disconnect", for: .normal)
                
            default:
                self.connectButton.setTitle("Connect", for: .normal)
            }
        }
        
        connectButton.addTarget(self, action: #selector(handler), for: .touchUpInside)
        applyFilterButton.addTarget(self, action: #selector(apply), for: .touchUpInside)
    }
    
    @objc func handler() {
        switch session.sessionState {
        case .none, .previewStarted, .ended, .error:
            session.startRtmpSession(
                url: Config.streamUrl,
                streamKey: Config.streamKey
            )
            
        default:
            session.endSession()
        }
    }
    
    @objc func apply() {
        isFiltered.toggle()
        session.filter = isFiltered ? FisheyeVideoFilter() : BasicVideoFilterBGRA()
    }
}
