
class Car {

  // We need to keep track of a Body and a width and height
  Body body;
  float w;
  float h;
  float rotation;
  Vec2 pos; 
  Vec2 vel;
  float mag;
  PImage car;

  // Constructor
  Car(float x, float y) {
    w = 50;
    h = 20;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    mag = 0;
    pos = new Vec2(x,y);
    vel = new Vec2(0.0,0.0);
    car = loadImage("car.png");
    car.resize(50,20);
  }

  void move() {
    accelerate();

    vel.x = cos(-rotation)*mag;
    vel.y = sin(-rotation)*mag;

    pos.x += vel.x;
    pos.y += vel.y;
    
    
    body.setTransform(body.getWorldCenter(), -rotation);
    body.setLinearVelocity(new Vec2(vel.x, vel.y));
  }

  void accelerate() {
    if (keyPressed && key == 'd') rotation += .1;
    if (keyPressed && key == 'a') rotation -= .1;
    if (mousePressed) {
      mag+=0.5;
    } else {
      if (mag > 0) mag -= 0.5;
      if (mag < 0) mag += 0.5;
      if (Math.abs(mag) < 0.7) mag = 0;
    }

    if (mag > 50) mag = 50;
  }

  // Drawing the box
  void display() {
    move();
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
