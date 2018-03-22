import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import java.util.*;

PImage startscreen;
PFont title;
int screenY = 600;
int screenX = 600;
int stage;


Box2DProcessing box2d;
Car b;
Point p1 = new Point();

ArrayList<AICar> enemies = new ArrayList<AICar>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<CircleObst> circleObstacles = new ArrayList<CircleObst>();
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();

Obstacle o;
AICar e;

void setup() {
  size(600, 600);

  stage = 1;
  startscreen = loadImage("Racecar.png");
  image(startscreen, 0, 0, width, height);
  title = createFont("font", 1000, true);


  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);

  b = new Car(150, 120);

  //stage 1
  obstacles.add(new Obstacle(50, 50));
  obstacles.add(new Obstacle(50, 150));
  obstacles.add(new Obstacle(50, 250));
  obstacles.add(new Obstacle(50, 350));
  obstacles.add(new Obstacle(50, 450));
  obstacles.add(new Obstacle(50, 550));
  obstacles.add(new Obstacle(150, 50));
  obstacles.add(new Obstacle(250, 50));
  obstacles.add(new Obstacle(350, 50));
  obstacles.add(new Obstacle(450, 50));
  obstacles.add(new Obstacle(550, 50));
  obstacles.add(new Obstacle(550, 150));
  obstacles.add(new Obstacle(550, 250));
  obstacles.add(new Obstacle(550, 350));
  obstacles.add(new Obstacle(550, 550));
  circleObstacles.add(new CircleObst(300, 300, 100));
  obstacles.add(new Obstacle(150, 550));
  obstacles.add(new Obstacle(250, 550));
  obstacles.add(new Obstacle(350, 550));
  obstacles.add(new Obstacle(450, 550));

  powerUps.add(new FreezeBomb((int)(300*Math.random()+150), 150));
  powerUps.add(new FreezeBomb((int)(300*Math.random()+150), 450));
  powerUps.add(new SpeedBoost(450, (int)(300*Math.random()+150)));


  //stage 2
  obstacles.add(new Obstacle(550 + 600, 50));
  o = new Obstacle(550 + 600, 150);
  obstacles.add(o);
  obstacles.add(new Obstacle(550 + width, 250));
  obstacles.add(new Obstacle(550 + width, 350));
  obstacles.add(new Obstacle(550 + width, 450));
  obstacles.add(new Obstacle(550 + width, 550));

  e = new AICar(115, 120);
  enemies.add(e);

  for (int i = 0; i < 2; i++) {
    enemies.add(new AICar(115, 120));
  }
}

void draw() {

  if (stage==1) {
    textAlign(CENTER);
    text("Car War", 250, 250);
    text("Press 1 for easy mode, 2 for medium mode, 3 for hard mode", 250, 350);
    if (keyPressed) stage = 2;
  }
  if (stage==2) {
    //println(box2d.getBodyPixelCoord(b.body).x + " " + box2d.getBodyPixelCoord(b.body).y);
    updateAll();
    if (box2d.getBodyPixelCoord(b.body).x > 590) {
      clearScreen();
      stage = 3;
      //translate(600,0);
      for (Obstacle obst : obstacles) obst.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(obst.body.getWorldCenter()).x-width, box2d.coordWorldToPixels(obst.body.getWorldCenter()).y)), obst.body.getAngle());
      for (CircleObst obst : circleObstacles) obst.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(obst.body.getWorldCenter()).x-width, box2d.coordWorldToPixels(obst.body.getWorldCenter()).y)), obst.body.getAngle());
      b.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(b.body.getWorldCenter()).x-width, box2d.coordWorldToPixels(b.body.getWorldCenter()).y)), -1*b.rotation);
      for (AICar a : enemies) a.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(a.body.getWorldCenter()).x-width, box2d.coordWorldToPixels(a.body.getWorldCenter()).y)), -1*a.rotation);
    }
  }
  if (stage == 3) {
    updateAll();
  }
}

void updateAll() {
  background(255);
  //println(box2d.coordWorldToPixels(e.body.getWorldCenter()).x);

  // We must always step through time!
  box2d.step();

  b.display();

  for (Obstacle obs : obstacles) {
    obs.display();
  }

  for (CircleObst obs : circleObstacles) {
    obs.display();
  }


  for (PowerUp p : powerUps) {
    if (p.getIsShown()) {
      p.display();
    }
    if (p.getIsShown() && b.intersect(p)) {
      if (p.getType() == 'f') {
        for (AICar d3 : enemies) {
          d3.stop();
        }
        p1.stop();
        p.setIsShown(false);
      } else if (p.getType() == 'b') {
        b.boost();
        p.setIsShown(false);
      }
    }
  }
  if (!p1.stopped) {
    p1.update();
    ellipse(p1.pos.x, p1.pos.y, 20, 20);
  }
  if (millis()-p1.m > 800) {
    p1.stopped = false;
  }

  for (AICar d3 : enemies) {
    d3.display(p1);
    if (d3.stopped) {
      d3.body.setLinearVelocity(new Vec2(0, 0));
    }
    if (millis()-d3.m > 800) {
      d3.stopped = false;
    }
  }
}

void clearScreen() {

  Iterator<PowerUp> iter2 = powerUps.iterator();

  while (iter2.hasNext()) {
    PowerUp o = iter2.next();
    iter2.remove();
  }
}
