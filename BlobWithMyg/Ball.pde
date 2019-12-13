class Ball {
  PVector location;
  PVector velocity;
  PVector accelaration;

  float mass;
  int id = 0;

  Ball() {
    location = new PVector(random(width), random(height));
    velocity = new PVector(0, 0);
    accelaration = new PVector(0, 0);
    mass = 0.4;
  }
  void move() {

    velocity.add(accelaration);
    location.add(velocity);
    velocity.limit(5);
    accelaration.mult(0);
  }
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    accelaration.add(f);
  }

  void bounce() {

    if ((location.x > width) || (location.x < 0)) {
      velocity.x = velocity.x * -1;
    }

    if ((location.y > height) || (location.y < 0)) {
      velocity.y = velocity.y * -1;
    }
  }
  void display() {
    stroke (0);
    strokeWeight (2);
    fill (127);
    ellipse (location.x, location.y, mass*20, mass*20);
  }
}
