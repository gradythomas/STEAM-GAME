class Obstacle {
  Body body;
  float w;
  float h;
  float rotation;
  PVector pos, vel;
  float mag;
  int terrain;
  PImage grass;
  PImage water;
  PImage wall;
  float x;
  float y;

  // Constructor
  Obstacle(float x, float y, int terrain) {
    w = 100;
    h = 100;
    this.x=x;
    this.y=y;
    this.terrain=terrain;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    mag = 0;
    pos = new PVector(x, y);
    vel = new PVector(0.0, 0.0);
    grass = loadImage("grass.png");
    grass.resize(100, 100);
    water = loadImage("water.png");
    water.resize(100, 100);
    wall = loadImage("brick.png");
    wall.resize(100, 100);
  }

  // Drawing the box
  void display() {
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
    if (terrain==1) {
      image(grass, -50, -50);
    }
    if (terrain==2) {
      image(water, -50, -50);
    }
    if (terrain==3) {
      image(wall, -50, -50);
    }
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
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }
}