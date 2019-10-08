import KinectPV2.*;
KinectPV2 kinect;

Ball[] balls;

color trackColor;

float threshold = 25;


void setup() {
  size(500, 500);
  kinect = new KinectPV2(this);

  kinect.enableColorImg(true);
  kinect.enableSkeletonColorMap(true);
  kinect.enableBodyTrackImg(true);
  kinect.enablePointCloud(true);

  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);

  kinect.init();


  trackColor = color(0, 0, 0);

  balls = new Ball[50];
  for (int i= 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(255);
  //image(kinect.getDepthImage(),0,0);
  PImage img=kinect.getBodyTrackImage();
  img.loadPixels();
  image(img, 0, 0, width, height);


  // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
  //float worldRecord = 500; 

  // XY coordinate of closest color
  //int closestX = 0;
  //int closestY = 0;

  float avgX = 0;
  float avgY = 0;

  int count = 0;


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
      float d = dist(r1, g1, b1, r2, g2, b2); // We are using the dist( ) function to compare the current color with the color we are tracking.

      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (d < threshold) {
        //worldRecord = d;
        avgX += x;
        avgY += y;
        count++;
        //closestX = x;
        //closestY = y;
      }
    }
  }


  // We only consider the color found if its color distance is less than 10. 
  // This threshold of 10 is arbitrary and you can adjust this number depending on how accurate you require the tracking to be.
  if (count > 0) { 
    avgX = avgX/count;
    avgY = avgY/count;
    // Draw a circle at the tracked pixel
    fill(255, 0, 0);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 16, 16);
  }

  for ( Ball b : balls) {

    PVector myg = PVector.random2D ();
    b.applyForce(myg);


//    if (mousePressed) {
      PVector mouse = new PVector(avgX, avgY);
      mouse.sub(b.location);
      mouse.setMag(0.5);
      b.applyForce(mouse);
//    }

    b.move();
    b.bounce();
    b.display();
  }
}
