class AICar extends Car {


  AICar(int xpos, int ypos) {
    super(xpos, ypos);
    car = loadImage("car2.png");
    car.resize(50, 20);
  }

  void accelerate(Car other) {
    float dist = dist(pos.x, pos.y, other.pos.x, other.pos.y);
    mag = dist * 0.05;
    float distx = other.pos.x - pos.x;
    float disty = other.pos.y - pos.y;
    if (distx > 0 && disty > 0) rotation = acos(distx/dist);
    if (distx < 0 && disty > 0) rotation = PI-acos((distx*-1)/(dist));
    if (distx < 0 && disty < 0) rotation = PI+acos((distx*-1)/(dist));
    if (distx > 0 && disty < 0) rotation = PI+acos((distx*-1)/(dist));
    if (mag > 12) mag = 12;
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
    popMatrix();
  }
}