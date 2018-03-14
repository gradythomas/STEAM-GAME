import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;
Car b;
Obstacle b2;
AICar b3;
ArrayList<AICar> enemies = new ArrayList<AICar>();
void setup() {
  size(640,360);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);
  b = new Car(400, 100);
  b2 = new Obstacle(150, 150);
  for (int i = 0; i < 10; i++) {
    enemies.add(new AICar(20, random(0, height)));
  }
  
}

void draw() {
   background(255);
  
  // We must always step through time!
  box2d.step();
  
  b.display();
  b2.display();
  for (AICar b3 : enemies) {
    b3.display(b);
  }
  
  
}
