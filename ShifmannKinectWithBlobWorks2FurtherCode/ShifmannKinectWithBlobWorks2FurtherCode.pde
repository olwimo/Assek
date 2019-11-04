import KinectPV2.*;
KinectPV2 kinect;

PImage img;

color trackColor;

float distThreshold = 25;

float threshold = 25;

ArrayList<Blob> blobs = new ArrayList<Blob>();

void setup() {
  size(512, 424, P3D);
  kinect = new KinectPV2(this);


  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);
  //kinect.enableInfraredImg(true);

  kinect.init();

  img = createImage(kinect.WIDTHDepth, kinect.HEIGHTDepth, RGB);

  trackColor = color(255, 0, 150);
}

void draw() {
  background(255);

  img.loadPixels();

  int[] depth = kinect.getRawDepthData();

  for (int x = 0; x < kinect.WIDTHDepth; x++ ) {
    for (int y = 0; y < kinect.HEIGHTDepth; y++ ) {
      int offset = x + y * kinect.HEIGHTDepth;
      int d = depth[offset];

      if (d>300 && d<1500) {

        img.pixels[offset] = color(255, 0, 150);
      } else {
        img.pixels[offset] = color(0);
      }
    }
  }

  img.updatePixels();
  image(img, 0, 0);

  blobs.clear();

  // Begin loop to walk through every pixel
  for (int x = 0; x < img.width; x ++ ) {
    for (int y = 0; y < img.height; y ++ ) {
      int loc = x + y*img.width;
      // What is current color
      color currentColor = img.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = distSq(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < threshold*threshold ) {
        //worldRecord = d;
        //avgX += x;
        //avgY += y;
        //count++;
        //closestX = x;
        //closestY = y;
        boolean found = false;
        for (Blob b : blobs) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }

        if (!found) {
          Blob b = new Blob(x, y);
          blobs.add(b);
        }
      }
    }
  }
  for (Blob b : blobs) {
    if (b.size()>500) {
      b.show();
    }
  }
}

float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) +(y2-y1)*(y2-y1);
  return d;
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  float d = (x2-x1)*(x2-x1) +(y2-y1)*(y2-y1)+(y2-y1)*(y2-y1);
  return d;
}
