import KinectPV2.*;
KinectPV2 kinect;
Ball[] balls;


float threshold =25;


void setup() {
  size(1920, 1080, P3D);
  kinect = new KinectPV2(this);

  kinect.enableColorImg(true);
  kinect.enableSkeletonColorMap(true);
  kinect.enableBodyTrackImg(true);
  kinect.enablePointCloud(true);

  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);

  kinect.init();

  balls = new Ball[50];
  for (int i= 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}
void draw() {
  background(255);



  PImage img=kinect.getBodyTrackImage();
  image(img, 0, 0, width, height);

  float avgx = 0;
  float avgy = 0;

  int count = 0;

  for (int x =0; x<width-1; x++) {
    for (int y =0; y<height; y++) {
      int loc = x+y*width;

      color currentColor = img.pixels[loc];

      float r1= red(currentColor);
      float g1= green(currentColor);
      float b1= blue(currentColor);
      float r2= red(currentColor);
      float g2= green(currentColor);
      float b2= blue(currentColor);

      float d = dist(r1, g1, b1, r2, g2, b2);

      if (d < threshold) {

        avgx += x;
        avgy += y;
        count++;
      }
    }
  }

  if (count> 0) {
    avgx = avgx/count;
    avgy = avgy/count;
  }
  //for ( Ball b : balls) {

  //  PVector myg = PVector.random2D ();
  //  b.applyForce(myg);


  //  if (mousePressed) {
  //    PVector mouse = new PVector(avgx, avgy);
  //    mouse.sub(b.location);
  //    mouse.setMag(0.5);
  //    b.applyForce(mouse);
  //  }

  //  b.move();
  //  b.bounce();
  //  b.display();
  //}
  fill(0);
  strokeWeight(4.0);
  stroke(127);
  ellipse(avgx, avgy, 16, 16);
  
}
