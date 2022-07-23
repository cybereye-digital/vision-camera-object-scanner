# vision-camera-object-scanner

VisionCamera Frame Processor Plugin to detect objects using MLKit Vision Object Detector

## Installation

```sh
yarn add vision-camera-object-scanner
```

## Usage

```js
import React, { useState, useEffect } from 'react';
import { runOnJS } from 'react-native-reanimated';
import {
  useCameraDevices,
  useFrameProcessor,
} from 'react-native-vision-camera';
import { Camera } from 'react-native-vision-camera';
import { scanForObjects, DetectedObject } from 'vision-camera-face-detector';

export default function App() {
  const [hasPermission, setHasPermission] = useState(false);
  const [objects, setObjects] = useState<DetectedObject[]>();

  const devices = useCameraDevices();
  const device = devices.front;

  useEffect(() => {
    console.log(objects);
  }, [objects]);

  useEffect(() => {
    (async () => {
      const status = await Camera.requestCameraPermission();
      setHasPermission(status === 'authorized');
    })();
  }, []);

  const frameProcessor = useFrameProcessor((frame) => {
    'worklet';
    const scannedObjects = scanForObjects(frame);
    runOnJS(setObjects)(scannedObjects);
  }, []);

  return device != null && hasPermission ? (
    <Camera
      style={{ flex: 1 }}
      device={device}
      isActive={true}
      frameProcessor={frameProcessor}
      frameProcessorFps={5}
    />
  ) : null;
}

```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
