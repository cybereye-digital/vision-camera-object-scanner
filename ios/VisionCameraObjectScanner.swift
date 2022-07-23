import Vision
import MLKitVision
import CoreML

@objc(ObjectScannerPlugin)
public class ObjectScannerPlugin: NSObject, FrameProcessorPluginBase {
  @objc public static func callback(_ frame: Frame!, withArgs _: [Any]!) -> Any! {
    let buffer = frame.buffer
    let orientation = frame.orientation
    // // get image from frame buffer
    // let image = VisionImage(buffer: buffer)
    // // prepare mlkit vision options
    // let options = ObjectDetectorOptions()
    // // options.detectorMode = .singleImage
    // options.shouldEnableMultipleObjects = true
    // options.shouldEnableClassification = true
    // create object detector instance w/ options
    // let objectDetector = ObjectDetector.objectDetector(options: options)
    // get object results
    // return objectDetector.results(in: image)
    return []
  }
}