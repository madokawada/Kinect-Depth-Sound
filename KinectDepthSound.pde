// Cherry Blossoms Dreamin'

// Derived from Daniel Shiffman's All features test
// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

//  "Press 'i' to enable/disable between video image and IR image
//  Press 'c' to enable/disable between color depth and gray scale depth
//  Press 'm' to enable/diable mirror mode
//  UP and DOWN to tilt camera   

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

float deg;

// Calculating for mask - 640*480=307,200
int[] maskImage = new int[307200];

PImage video;
PImage cherry;

boolean ir = false;
boolean colorDepth = false;
boolean mirror = true;

Petal[] petals = new Petal[300];
Sound sounds;

void setup() {
  size(640, 480);
  background(255);
  cherry = loadImage("data/cherry.jpg");
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();
  kinect.enableColorDepth(colorDepth);
  kinect.enableMirror(mirror);
    
  deg = kinect.getTilt();
  
  for (int i = 0; i < petals.length; i++) {
    petals[i] = new Petal();
  }
  sounds = new Sound(this);
}


void draw() {
  image(cherry, 0, 0);
  
  //float skip = 1;
  int[] depth = kinect.getRawDepth();
  for(int x = 0; x < kinect.width; x ++) {
    for(int y = 0; y < kinect.height; y ++) {
      int offset = x + y * kinect.width;

      // Convert kinect data to world xyz coordinate
      int rawDepth = depth[offset];
      float depthInMeters = 1.0 / (rawDepth * -0.0030711016 + 3.3309495161);
      //PVector v = depthToWorld(x, y, rawDepth);
      
      if(depthInMeters > 1){
        maskImage[offset] = 0;
      } else {
        maskImage[offset] = 255;
      }
    }
  }
  
  video = kinect.getVideoImage();
  video.mask(maskImage);
  image(video, 0, 0);
  
    
  pushMatrix();
  sounds.play(maskImage);
  sounds.display();
  
  for (int i = 0; i < petals.length; i++) {
    petals[i].descend(maskImage);
    petals[i].display();
  }
  
  popMatrix();
}

void keyPressed() {
  if (key == 'i') {
    ir = !ir;
    kinect.enableIR(ir);
  } else if (key == 'c') {
    colorDepth = !colorDepth;
    kinect.enableColorDepth(colorDepth);
  }else if(key == 'm'){
    mirror = !mirror;
    kinect.enableMirror(mirror);
  } else if (key == CODED) {
    if (keyCode == UP) {
      deg++;
    } else if (keyCode == DOWN) {
      deg--;
    }
    deg = constrain(deg, 0, 30);
    kinect.setTilt(deg);
  }
}