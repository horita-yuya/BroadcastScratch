import CoreImage
import HaishinKit
import AVFoundation

final class CIMonochromeEffect: VisualEffect {
    let filter: CIFilter? = CIFilter(name: "CIColorMonochrome")
    
    override func execute(_ image: CIImage, info: CMSampleBuffer?) -> CIImage {
        guard let filter: CIFilter = filter else {
            return image
        }
        filter.setValue(image, forKey: "inputImage")
        filter.setValue(CIColor(red: 0.75, green: 0.75, blue: 0.75), forKey: "inputColor")
        filter.setValue(1.0, forKey: "inputIntensity")
        return filter.outputImage!
    }
}

final class MonochromeEffect: VisualEffect {
    private let kernel: CIKernel
    
    override init() {
        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
        let data = try! Data(contentsOf: url)
        kernel = try! CIKernel(functionName: "monochrome", fromMetalLibraryData: data)
    }
    
    override func execute(_ image: CIImage, info: CMSampleBuffer?) -> CIImage {
        let sampler = CISampler(image: image)
        return kernel.apply(extent: image.extent, roiCallback: { _, rect in rect }, arguments: [sampler])!
    }
}

//final class ChromaKey: VisualEffect {
//    private let kernel: CIKernel
//    private let backImage: UIImage = UIImage(named: "uyuni")!
//    private lazy var ciBackImage = CIImage(cgImage: backImage.cgImage!)
//
//    override init() {
//        let url = Bundle.main.url(forResource: "default", withExtension: "metallib")!
//        let data = try! Data(contentsOf: url)
//        kernel = try! CIKernel(functionName: "chromakey", fromMetalLibraryData: data)
//    }
//
//    override func execute(_ image: CIImage, info: CMSampleBuffer?) -> CIImage {
//        let sampler = CISampler(image: image)
//        let sampler2 = CISampler(image: ciBackImage)
//        return kernel.apply(extent: image.extent, roiCallback: { _, rect in rect }, arguments: [sampler, sampler2])!
//    }
//}
