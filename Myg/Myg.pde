import KinectPV2.KJoint;
import KinectPV2.*;

float lefthandX;
float lefthandY;
float righthandY;
float righthandX;

Ball[] balls;
Mand m;

KinectPV2 kinect;

void setup() {
  size(1000, 900);
  
  m = new Mand();

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableColorImg(true);

  kinect.init();

  balls = new Ball[50];
  for (int i= 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}
void draw() {
  background(255);

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      //drawBody(joints);

      //draw different color for each hand state
      //drawHandState(joints[KinectPV2.JointType_HandRight]);
      //drawHandState(joints[KinectPV2.JointType_HandLeft]);
      
      lefthandX = joints[KinectPV2.JointType_HandLeft].getX();
      lefthandY = joints[KinectPV2.JointType_HandLeft].getY();
      righthandX = joints[KinectPV2.JointType_HandRight].getX();
      righthandY = joints[KinectPV2.JointType_HandRight].getY();
      
      text("LefthandX: " + lefthandX, 12, 120);
      text("LefthandY: " + lefthandY, 12, 140);
      text("RighthandX: " + righthandX, 12, 160);
      text("RighthandY: " +righthandY, 12, 180);
      
      //rect(joints[KinectPV2.JointType_HandRight].getX(), (joints[KinectPV2.JointType_HandRight].getY()), 30, 30);
      
      /*if(startButton.righthandOverRect() || startButton.lefthandOverRect() || startButton.mouseOverRect()) {
        startButton.setColor(140);
        fill(200);
        ellipse(500, 500, 30, 30);
        } else {
        fill(40);
      }*/
    }
  }



  for ( Ball b : balls) {

    PVector myg = PVector.random2D ();
    b.applyForce(myg);


    if (mousePressed) {
      PVector mouse = new PVector(mouseX, mouseY);
      mouse.sub(b.location);
      mouse.setMag(0.5);
      b.applyForce(mouse);
    }

    b.move();
    b.bounce();
    b.display();
  }
  
  m.mand();
}
