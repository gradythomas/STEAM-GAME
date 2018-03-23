
class AICar {

  // We need to keep track of a Body and a width and height
  PImage car;
  Body body;
  float w;
  float h;
  float rotation;
  float goal;
  Vec2 pos, vel;
  float mag;
  boolean immunity, stopped;
  int m;


  // Constructor
  AICar(float x, float y) {
    stopped = false;
    w = 50;
    h = 20;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
    mag = 0;
    pos = new Vec2(x, y);
    vel = new Vec2(0.0, 0.0);
    car = loadImage("car2.png");
    car.resize(50,20);
    goal = 0;
    rotation = 0;
  }

  void accelerate(Point other) {
    float dist = dist(box2d.getBodyPixelCoord(body).x, box2d.getBodyPixelCoord(body).y, other.pos.x, other.pos.y/*+50*sin(other.rotation)*/);
    if (mag < 12*difficultyFactor) 
      mag+= (float) Math.random();
    float distx = (other.pos.x/*+50*cos(other.rotation)*/) - box2d.getBodyPixelCoord(body).x;
    float disty = (other.pos.y/*+50*sin(other.rotation)*/) - box2d.getBodyPixelCoord(body).y;

    if (distx > 0 && disty > 0) {goal = acos(distx/dist);}
    if (distx < 0 && disty > 0) {goal = PI-acos((distx*-1)/(dist));}
    if (distx < 0 && disty < 0) {goal = PI+acos((distx*-1)/(dist));}
    if (distx > 0 && disty < 0) {goal = PI+acos((distx*-1)/(dist));}
    
    //if (rotation > 2 * PI || rotation < 0)rotation %= (2*PI);
    //if (goal > 2 * PI || goal < 0)goal %= (2*PI);
    
    /*if (goal < rotation && rotation - goal > PI) rotation -= .05;
    if (goal < rotation && rotation - goal < PI) rotation += .05;
    if (goal > rotation && goal - rotation < PI) rotation += .05;
    if (goal > rotation && goal - rotation > PI) rotation -= .05;*/
    
    //if (Math.abs(rotation - goal) < 1) rotation = goal;
    //rotation += goal/60;
    //if (millis() % 1000 >= 250) {
    //  rotation = goal;
    //} else  if (millis() % 1000 > 125) {
    //  rotation += (float) Math.random() * 0.1;
    //} else {
    //  rotation -= (float) Math.random() * 0.1;
    //}
    //if (dist < 100) mag = 7;
    rotation = goal;
  }

  void move(Point other) {
    accelerate(other);
    //mag += (float) (Math.random() - 0.5)*4;
    vel.x = cos(rotation)*mag;
    vel.y = sin(-rotation)*mag;

    pos.x += vel.x;
    pos.y += vel.y;

    body.setTransform(body.getWorldCenter(), -rotation);
    body.setLinearVelocity(new Vec2(vel.x, vel.y).mulLocal(3));
  }

void stop() {
    m = millis();
    stopped = true;
  }



  // Drawing the box
  void display(Point other) {
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