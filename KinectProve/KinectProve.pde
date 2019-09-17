import KinectPV2.*;
KinectPV2 kinect;



void setup(){
size(1920, 1080, P3D);
kinect = new KinectPV2(this);

kinect.enableColorImg(true);
kinect.enableSkeletonColorMap(true);
kinect.enableBodyTrackImg(true);
kinect.enablePointCloud(true);

kinect.enableDepthMaskImg(true);
kinect.enableSkeletonDepthMap(true);

kinect.init();

}
void draw(){
background(255);
image(kinect.getDepthMaskImage(),0,0, 1920, 1080);
ArrayList<KSkeleton>skeletonArray = kinect.getSkeletonDepthMap();
for(int i = 0; i< skeletonArray.size(); i++){
  KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
  KJoint[] joints = skeleton.getJoints();
  color col = skeleton.getIndexColor();
  fill(col);
  stroke(col);

}
//image(kinect.getColorImage(), 0,0);
//image(kinect.getBodyTrackImage(),0,0);
//image(
//image(kinect.getDepthImage(),0,0);

//Skeleton skeleton = kinect.getSkeleton();

}
