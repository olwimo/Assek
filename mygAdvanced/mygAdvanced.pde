Ball[] balls;

void setup() {
  size(1000, 900);
  
    balls = new Ball[50];
  for (int i= 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(255);
  
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
}
