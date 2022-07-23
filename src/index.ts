import type { Frame } from 'react-native-vision-camera'

/**
 * Scans for detectable objects.
 */

type CGRect = { 
  minX: number; 
  minY: number; 
  midX: number; 
  midY: number; 
  maxX: number; 
  maxY: number; 
  width: number; 
  height: number;
};

type BoundingBox = {
  x: number;
  y: number;
  width: number;
  height: number;
  boundingCenterX: number;
  boundingCenterY: number;
}

type Label = { 
  text: string; 
  confidence: number 
};

export interface DetectedObject {
  trackingID: number;
  frame: CGRect;
  bbox: BoundingBox;
  labels: Label[];
}

export function scanForObjects(frame: Frame): DetectedObject[] {
  'worklet'
  return __scanForObjects(frame)
}