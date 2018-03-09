class AICar extends Car {

  boolean collided;
  boolean changed;

  AICar(int xpos, int ypos) {
    super(xpos, ypos);
    car = loadImage("car2.png");
    car.resize(50, 20);
  }

  void accelerate(Car other) {
    float dist = dist(pos.x, pos.y, (other.pos.x+50*cos(other.rotation)), (other.pos.y+50*sin(other.rotation)));
    mag+=0.1;
    float distx = (other.pos.x+50*cos(other.rotation)) - pos.x;
    float disty = (other.pos.y+50*sin(other.rotation)) - pos.y;
    if (!collided) {
      if (distx > 0 && disty > 0) rotation = acos(distx/dist);
      if (distx < 0 && disty > 0) rotation = PI-acos((distx*-1)/(dist));
      if (distx < 0 && disty < 0) rotation = PI+acos((distx*-1)/(dist));
      if (distx > 0 && disty < 0) rotation = PI+acos((distx*-1)/(dist));
    } else {
      rotation+=PI/6;
      if (dist(pos.x-10, pos.y, other.pos.x-10, other.pos.y) > 100 || dist(pos.x-10, pos.y, other.pos.x+10, other.pos.y) > 100 || dist(pos.x+10, pos.y, other.pos.x-10, other.pos.y) > 100 || dist(pos.x+10, pos.y, other.pos.x+10, other.pos.y) > 100) {
        collided = false;
        changed = false;
      }
    }

    if (mag > 7) mag = 7;
  }

  void move(Car other) {
    accelerate(other);

    vel.x = cos(rotation)*mag;
    vel.y = sin(rotation)*mag;

    pos.x += vel.x;
    pos.y += vel.y;
  }

  void update(Car other) {
    move(other);

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    image(car, -25, -10);
    //ellipse(-10, 0, 20, 20);
    //ellipse(10, 0, 20, 20);
    popMatrix();
  }
}
