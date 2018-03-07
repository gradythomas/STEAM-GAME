public class Car {
  PVector vel, pos;
  float rotation;
  float mag;

  Car(int xpos, int ypos) {
    pos = new PVector(xpos, ypos);
    vel = new PVector(0.0, 0.0);
    rotation = 0;
    mag = 0;
  }

  void move() {
    accelerate();
    if (keyPressed && key == 'd') rotation += .1;
    if (keyPressed && key == 'a') rotation -= .1;
  
    vel.x = cos(rotation)*mag;
    vel.y = sin(rotation)*mag;
    
    pos.x += vel.x;
    pos.y += vel.y;
  }

  void accelerate() {
    if (mousePressed) {
      mag+=0.1;
    } else {
      if (mag > 0) mag -= .1;
      if (mag < 0) mag += .1;
      if (Math.abs(mag) < 0.7) mag = 0;
    }
    
    if (mag > 5) mag = 5;
  }

  void update() {
    move();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    rect(0, 0, 50, 10);
    popMatrix();
  }
}