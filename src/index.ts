import type { Frame } from 'react-native-vision-camera'

/**
 * Scans Objects.
 */

type CGRect = { x: number; y: number, width: number, height: number };
type Label = { text: string, confidence: number };
export interface DetectedObject {
  frame: CGRect;
  trackingId: number;
  labels: Label[];
}

export default function scanForObjects(frame: Frame): DetectedObject[] {
  'worklet'
  return __scanForObjects(frame)
}