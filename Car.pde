public class Car {
  protected PVector vel, pos;
  protected float rotation;
  protected float mag;
  protected PImage car;

  Car(int xpos, int ypos) {
    pos = new PVector(xpos, ypos);
    vel = new PVector(0.0, 0.0);
    rotation = 0;
    mag = 0;
    car = loadImage("car.png");
    car.resize(50,20);
  }

  void move() {
    accelerate();
  
    vel.x = cos(rotation)*mag;
    vel.y = sin(rotation)*mag;
    
    pos.x += vel.x;
    pos.y += vel.y;
  }

  void accelerate() {
    if (keyPressed && key == 'd') rotation += .1;
    if (keyPressed && key == 'a') rotation -= .1;
    if (mousePressed) {
      mag+=0.1;
    } else {
      if (mag > 0) mag -= .1;
      if (mag < 0) mag += .1;
      if (Math.abs(mag) < 0.7) mag = 0;
    }
    
    if (mag > 8) mag = 8;
  }
  
  //checks by drawing two circles inside each car
  void checkCollision(AICar other) {
    if (dist(pos.x-10, pos.y, other.pos.x-10, other.pos.y) < 30 || dist(pos.x-10, pos.y, other.pos.x+10, other.pos.y) < 30 || dist(pos.x+10, pos.y, other.pos.x-10, other.pos.y) < 30 || dist(pos.x+10, pos.y, other.pos.x+10, other.pos.y) < 30) {
      other.collided = true;
    } else {
    }
  }

  void update() {
    move();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    image(car, -25,-10);
    //ellipse(-10, 0, 20, 20);
    //ellipse(10, 0, 20, 20);
    popMatrix();
  }
}
