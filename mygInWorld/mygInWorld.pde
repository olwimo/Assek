import KinectPV2.*;
KinectPV2 kinect;

Ball[] balls;

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
  //image(kinect.getDepthImage(),0,0);
  PImage img=kinect.getBodyTrackImage();
  image(img, 0, 0, width, height);

  for ( Ball b : balls) {

    PVector myg = PVector.random2D ();
    b.applyForce(myg);


    if (mousePressed) {
      loadPixels();
      for (int x =0; x<width-1; x++) {
        for (int y =0; y<height; y++) {
          
          int loc = x+y*width;
          int locx = x;
          int locy= y*width;
          pixels[locx]=color(0);
          pixels[locy]=color(0);
          //pixels[loc]=color(0,0,0);
          //float bright = brightness(pixels[loc]);
          //float r = red(pixels[loc]);
          //float g = green(pixels[loc]);
          //float blue = blue(pixels[loc]);
          //pixels[loc] = color(0, 0, 0);
          PVector mouse = new PVector(locx, locy);
          mouse.sub(b.location);
          mouse.setMag(0.5);
          b.applyForce(mouse);
        }
      }
      updatePixels();
    }

    b.move();
    b.bounce();
    b.display();
  }
}
