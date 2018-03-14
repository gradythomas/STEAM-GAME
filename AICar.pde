
class AICar {

  // We need to keep track of a Body and a width and height
  PImage car;
  Body body;
  float w;
  float h;
  float rotation;
  Vec2 pos, vel;
  float mag;

  // Constructor
  AICar(float x, float y) {
    w = 50;
    h = 20;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    mag = 0;
    pos = new Vec2(x, y);
    vel = new Vec2(0.0, 0.0);
    car = loadImage("car2.png");
    car.resize(50,20);
  }

  void accelerate(Car other) {
    float dist = dist(box2d.getBodyPixelCoord(body).x, box2d.getBodyPixelCoord(body).y, (box2d.getBodyPixelCoord(other.body).x/*+50*cos(other.rotation)*/), (box2d.getBodyPixelCoord(other.body).y/*+50*sin(other.rotation)*/));
    mag+=0.1;
    float distx = (box2d.getBodyPixelCoord(other.body).x/*+50*cos(other.rotation)*/) - box2d.getBodyPixelCoord(body).x;
    float disty = (box2d.getBodyPixelCoord(other.body).y/*+50*sin(other.rotation)*/) - box2d.getBodyPixelCoord(body).y;

    if (distx > 0 && disty > 0) rotation = acos(distx/dist);
    if (distx < 0 && disty > 0) rotation = PI-acos((distx*-1)/(dist));
    if (distx < 0 && disty < 0) rotation = PI+acos((distx*-1)/(dist));
    if (distx > 0 && disty < 0) rotation = PI+acos((distx*-1)/(dist));

    if (mag > 20) mag = 20;
  }

  void move(Car other) {
    accelerate(other);

    vel.x = cos(rotation)*mag;
    vel.y = sin(-rotation)*mag;

    pos.x += vel.x;
    pos.y += vel.y;

    body.setTransform(body.getWorldCenter(), -rotation);
    body.setLinearVelocity(new Vec2(vel.x, vel.y).mulLocal(3));
  }




  // Drawing the box
  void display(Car other) {
    move(other);
    // We look at each body and get its screen position
    Vec2 pos3 = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    //float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos3.x, pos3.y);
    rotate(rotation);
    fill(175);
    stroke(0);
    image(car, -25,-10);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }
}
