import UIKit
import AVFoundation
import HaishinKit
import Photos
import MetalKit

final class HaishinKitViewController: UIViewController {
    private let rtmpConnection = RTMPConnection()
    private lazy var rtmpStream = RTMPStream(connection: rtmpConnection)
    private var currentEffect: VisualEffect?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let c = currentEffect {
            currentEffect = nil
            _ = rtmpStream.unregisterEffect(video: c)
        } else {
            currentEffect = MonochromeEffect()
            let result = rtmpStream.registerEffect(video: currentEffect!)
            print(result)
        }
    }
}

private extension HaishinKitViewController {
    func configure() {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setPreferredSampleRate(44_100)
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setMode(.default)
            try session.setActive(true)
            
        } catch {
            print(error)
        }
        
        rtmpStream.attachAudio(AVCaptureDevice.default(for: .audio)) { _ in }
        rtmpStream.attachCamera(DeviceUtil.device(withPosition: .back)) { error in }
        
        let hkView = MTHKView(frame: view.bounds)
        hkView.videoGravity = .resizeAspectFill
        hkView.attachStream(rtmpStream)
        
        rtmpConnection.connect(Config.streamUrl)
        rtmpStream.publish(Config.streamKey)
        
        view.addSubview(hkView)
    }
}
