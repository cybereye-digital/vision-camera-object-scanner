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
  }()

  static var objectDetector = ObjectDetector.objectDetector(options: ObjectDetectorOption)

    private static func processFrame(from object: Object) -> [String: Any] {
        let frame = object.frame

        return [
          "minX": frame.minX,
          "minY": frame.minY,
          "midX": frame.midX,
          "midY": frame.midY,
          "maxX": frame.maxX,
          "maxY": frame.maxY,
          "width": frame.width,
          "height": frame.height
        ]
    }
    
    private static func processBoundingBox(from object: Object) -> [String: Any] {
        let frameRect = object.frame

        let offsetX = (frameRect.midX - ceil(frameRect.width)) / 2.0
        let offsetY = (frameRect.midY - ceil(frameRect.height)) / 2.0

        let x = frameRect.maxX + offsetX
        let y = frameRect.minY + offsetY

        return [
          "x": frameRect.midX + (frameRect.midX - x),
          "y": frameRect.midY + (y - frameRect.midY),
          "width": frameRect.width,
          "height": frameRect.height,
          "boundingCenterX": frameRect.midX,
          "boundingCenterY": frameRect.midY
        ]
    }

  private static func processLabels(from object: Object) -> [Any] {
      let labels = object.labels
      
      var results: [Any] = []
      
      if (!labels.isEmpty) {
          for label in labels {
              var result: [String: Any] = [:]
              
              result["text"] = label.text
              result["confidence"] = label.confidence
              
              results.append(result)
          }
      }

      return results
  }

  @objc public static func callback(_ frame: Frame!, withArgs _: [Any]!) -> Any! {
    // get image from frame buffer
    let image = VisionImage(buffer: frame.buffer)

    // prepare for results
    var detectedObjects: [Any] = []

    // get detected objects from image
    do {
        let objects: [Object] = try objectDetector.results(in: image)
        
        if (!objects.isEmpty){
            for object in objects {
                var result: [String: Any] = [:]

                result["trackingID"] = object.trackingID
                result["frame"] = processFrame(from: object)
                result["bbox"] = processBoundingBox(from: object)
                result["labels"] = processLabels(from: object)

                detectedObjects.append(result)
            }
        }
    } catch _ {
      return nil
    }

    return detectedObjects
  }
}