import Vision
import MLKitObjectDetection
import MLKitVision
import CoreML

@objc(ObjectScannerPlugin)
public class ObjectScannerPlugin: NSObject, FrameProcessorPluginBase {
  static var ObjectDetectorOption: ObjectDetectorOptions = {
    let options = ObjectDetectorOptions()
    // options.detectorMode = .singleImage
    options.shouldEnableMultipleObjects = true
    options.shouldEnableClassification = true
    return options
  }

  static var objectDetector = ObjectDetector.objectDetector(options: ObjectDetectorOption)

  @objc public static func callback(_ frame: Frame!, withArgs _: [Any]!) -> Any! {
    // get image from frame buffer
    let image = VisionImage(buffer: frame.buffer)

    // get detected objects from image
    do {
      let detectedObjects: [Object] = try objectDetector.results(in: image)
    } catch _ {
      return nil
    }

    return detectedObjects
  }
}