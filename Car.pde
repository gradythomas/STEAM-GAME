
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
  boolean boosted = false;
  int m;

  // Constructor
  Car(float x, float y) {
    w = 50;
    h = 20;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    mag = 0;
    pos = new Vec2(x, y);
    vel = new Vec2(0.0, 0.0);
    car = loadImage("car.png");
    car.resize(50, 20);
  }

  void move() {

    {      
      if ((millis()-m)>1000)
        boosted=false;

      if (boosted)
        accelerate2();
      else if (!boosted)
        accelerate();

      vel.x = cos(-rotation)*mag;
      vel.y = sin(-rotation)*mag;

      //if (box2d.getBodyPixelCoord(b.body).x>1 && box2d.getBodyPixelCoord(b.body).x<399 && box2d.getBodyPixelCoord(b.body).y>1 && box2d.getBodyPixelCoord(b.body).y<399)
      pos.x += vel.x;
      pos.y += vel.y;

      body.setTransform(body.getWorldCenter(), -rotation);
      body.setLinearVelocity(new Vec2(vel.x, vel.y));
    }
  }

  void boost()
  {
    boosted = true;
    m = millis();
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

    if (mag > 30) mag = 30;
  }

  void accelerate2() {
    if (keyPressed && key == 'd') rotation += .1;
    if (keyPressed && key == 'a') rotation -= .1;
    if (mousePressed) {
      mag+=5;
    } else {
      if (mag > 0) mag -= 0.5;
      if (mag < 0) mag += 0.5;
      if (Math.abs(mag) < 0.7) mag = 0;
    }

    if (mag > 60) mag = 60;
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
    image(car, -25, -10);
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

  boolean intersect(PowerUp p) {

    // Objects can be passed into functions as arguments too! 
    float distance = dist(box2d.getBodyPixelCoord(b.body).x, box2d.getBodyPixelCoord(b.body).y, p.x, p.y); // Calculate distance

    if (distance < 1.5*p.r) {
      return true;
    } else {
      return false;
    }
  }
}