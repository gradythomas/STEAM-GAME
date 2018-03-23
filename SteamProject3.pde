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
  size(800, 600);

  stage = 1;
  startscreen = loadImage("StartScreen.png");
  image(startscreen, 0, 0, width, height);


  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);

  b = new Car(150, 120);

  //stage 2
  circleObstacles.add(new CircleObst(300, 300, 100));
  obstacles.add(new Obstacle(50, 50, 3));
  obstacles.add(new Obstacle(50, 150, 3));
  obstacles.add(new Obstacle(50, 250, 3));
  obstacles.add(new Obstacle(50, 350, 1));
  obstacles.add(new Obstacle(50, 450, 1));
  obstacles.add(new Obstacle(50, 550, 1));

  obstacles.add(new Obstacle(150, 50, 3));
  obstacles.add(new Obstacle(150, 250, 3));
  obstacles.add(new Obstacle(150, 350, 1));
  obstacles.add(new Obstacle(150, 450, 1));

  obstacles.add(new Obstacle(250, 50, 3));
  obstacles.add(new Obstacle(250, 250, 3));
  obstacles.add(new Obstacle(250, 350, 1));
  obstacles.add(new Obstacle(250, 450, 1));

  obstacles.add(new Obstacle(350, 50, 3));
  obstacles.add(new Obstacle(350, 350, 3));
  obstacles.add(new Obstacle(350, 450, 3));

  obstacles.add(new Obstacle(450, 50, 3));

  obstacles.add(new Obstacle(550, 50, 3));
  obstacles.add(new Obstacle(550, 150, 3));
  obstacles.add(new Obstacle(550, 250, 3));
  obstacles.add(new Obstacle(550, 350, 3));
  obstacles.add(new Obstacle(550, 550, 3));

  obstacles.add(new Obstacle(650, 50, 1));
  obstacles.add(new Obstacle(650, 150, 1));
  obstacles.add(new Obstacle(650, 250, 1));
  obstacles.add(new Obstacle(650, 350, 3));
  obstacles.add(new Obstacle(650, 550, 3));

  obstacles.add(new Obstacle(750, 50, 1));
  obstacles.add(new Obstacle(750, 150, 1));
  obstacles.add(new Obstacle(750, 250, 1));
  obstacles.add(new Obstacle(750, 350, 3));
  obstacles.add(new Obstacle(750, 550, 3));

  obstacles.add(new Obstacle(150, 550, 1));
  obstacles.add(new Obstacle(250, 550, 1));
  obstacles.add(new Obstacle(350, 550, 3));
  obstacles.add(new Obstacle(450, 550, 3));

  powerUps.add(new FreezeBomb((int)(300*Math.random()+150), 150));
  powerUps.add(new FreezeBomb((int)(300*Math.random()+150), 450));
  powerUps.add(new SpeedBoost(450, (int)(300*Math.random()+150)));


  //stage 3
  obstacles.add(new Obstacle(50 + width, 50, 1));
  obstacles.add(new Obstacle(50 + width, 150, 1));
  obstacles.add(new Obstacle(50 + width, 250, 1));
  obstacles.add(new Obstacle(50 + width, 350, 1));
  obstacles.add(new Obstacle(50 + width, 550, 1));

  obstacles.add(new Obstacle(150 + width, 50, 1));
  obstacles.add(new Obstacle(150 + width, 550, 1));


  obstacles.add(new Obstacle(250 + width, 50, 1));
  //obstacles.add(new Obstacle(250 + width, 150));
  obstacles.add(new Obstacle(250 + width, 250, 1));
  obstacles.add(new Obstacle(250 + width, 350, 1));
  obstacles.add(new Obstacle(250 + width, 450, 2));
  obstacles.add(new Obstacle(250 + width, 550, 2));

  obstacles.add(new Obstacle(350 + width, 50, 2));
  //obstacles.add(new Obstacle(350 + width, 150));
  obstacles.add(new Obstacle(350 + width, 250, 2));
  obstacles.add(new Obstacle(350 + width, 350, 2));
  obstacles.add(new Obstacle(350 + width, 450, 2));
  obstacles.add(new Obstacle(350 + width, 550, 2));

  obstacles.add(new Obstacle(450 + width, 50, 3));
  //obstacles.add(new Obstacle(450 + width, 150));
  //obstacles.add(new Obstacle(450 + width, 250));
  //obstacles.add(new Obstacle(450 + width, 350));
  //obstacles.add(new Obstacle(450 + width, 550));

  obstacles.add(new Obstacle(550 + width, 50, 3));
  obstacles.add(new Obstacle(550 + width, 150, 3));
  obstacles.add(new Obstacle(550 + width, 250, 3));
  obstacles.add(new Obstacle(550 + width, 350, 3));
  obstacles.add(new Obstacle(550 + width, 450, 3));
  obstacles.add(new Obstacle(550 + width, 550, 3));

  obstacles.add(new Obstacle(650 + width, 50, 1));
  obstacles.add(new Obstacle(650 + width, 150, 1));
  obstacles.add(new Obstacle(650 + width, 250, 1));
  obstacles.add(new Obstacle(650 + width, 350, 1));
  obstacles.add(new Obstacle(650 + width, 450, 1));
  obstacles.add(new Obstacle(650 + width, 550, 1));

  obstacles.add(new Obstacle(750 + width, 50, 1));
  obstacles.add(new Obstacle(750 + width, 150, 1));
  obstacles.add(new Obstacle(750 + width, 250, 1));
  obstacles.add(new Obstacle(750 + width, 350, 1));
  obstacles.add(new Obstacle(750 + width, 450, 1));
  obstacles.add(new Obstacle(750 + width, 550, 1));

  //stage 4
  obstacles.add(new Obstacle(50 + width, 50+height, 1));
  obstacles.add(new Obstacle(50 + width, 150+height, 1));
  obstacles.add(new Obstacle(50 + width, 250+height, 1));
  obstacles.add(new Obstacle(50 + width, 350+height, 1));
  obstacles.add(new Obstacle(50 + width, 550+height, 1));

  obstacles.add(new Obstacle(150 + width, 50+height, 1));
  obstacles.add(new Obstacle(150 + width, 550+height, 1));


  obstacles.add(new Obstacle(250 + width, 50+height, 1));
  //obstacles.add(new Obstacle(250 + width, 150));
  obstacles.add(new Obstacle(250 + width, 250+height, 1));
  obstacles.add(new Obstacle(250 + width, 350+height, 1));
  obstacles.add(new Obstacle(250 + width, 450+height, 2));
  obstacles.add(new Obstacle(250 + width, 550+height, 2));

  obstacles.add(new Obstacle(350 + width, 50+height, 2));
  //obstacles.add(new Obstacle(350 + width, 150));
  obstacles.add(new Obstacle(350 + width, 250+height, 2));
  obstacles.add(new Obstacle(350 + width, 350+height, 2));
  obstacles.add(new Obstacle(350 + width, 450+height, 2));
  obstacles.add(new Obstacle(350 + width, 550+height, 2));

  //obstacles.add(new Obstacle(450 + width, 50+height, 3));
  //obstacles.add(new Obstacle(450 + width, 150));
  obstacles.add(new Obstacle(450 + width, 250+height, 3));
  obstacles.add(new Obstacle(450 + width, 350+height, 3));
  obstacles.add(new Obstacle(450 + width, 450+height, 3));
  obstacles.add(new Obstacle(450 + width, 550+height, 3));

  obstacles.add(new Obstacle(550 + width, 50+height, 3));
  obstacles.add(new Obstacle(550 + width, 150+height, 3));
  obstacles.add(new Obstacle(550 + width, 250+height, 3));
  obstacles.add(new Obstacle(550 + width, 350+height, 3));
  obstacles.add(new Obstacle(550 + width, 450+height, 3));
  obstacles.add(new Obstacle(550 + width, 550+height, 3));
  
  obstacles.add(new Obstacle(650 + width, 50+height, 1));
  obstacles.add(new Obstacle(650 + width, 150+height, 1));
  obstacles.add(new Obstacle(650 + width, 250+height, 1));
  obstacles.add(new Obstacle(650 + width, 350+height, 1));
  obstacles.add(new Obstacle(650 + width, 450+height, 1));
  obstacles.add(new Obstacle(650 + width, 550+height, 1));

  obstacles.add(new Obstacle(750 + width, 50+height, 1));
  obstacles.add(new Obstacle(750 + width, 150+height, 1));
  obstacles.add(new Obstacle(750 + width, 250+height, 1));
  obstacles.add(new Obstacle(750 + width, 350+height, 1));
  obstacles.add(new Obstacle(750 + width, 450+height, 1));
  obstacles.add(new Obstacle(750 + width, 550+height, 1));


  //stage 5
  obstacles.add(new Obstacle(50, 50+height, 1));
  //obstacles.add(new Obstacle(50, 150+height, 1));
  obstacles.add(new Obstacle(50, 250+height, 1));
  obstacles.add(new Obstacle(50, 350+height, 1));
  obstacles.add(new Obstacle(50, 450+height, 1));
  obstacles.add(new Obstacle(50, 550+height, 1));

  obstacles.add(new Obstacle(150, 50+height, 1));
  //obstacles.add(new Obstacle(150, 150+height, 1));
  obstacles.add(new Obstacle(150, 250+height, 1));
  obstacles.add(new Obstacle(150, 350+height, 1));
  obstacles.add(new Obstacle(150, 450+height, 1));
  obstacles.add(new Obstacle(150, 550+height, 1));


  obstacles.add(new Obstacle(250, 50+height, 1));
  //obstacles.add(new Obstacle(250, 150+height, 1));
  //obstacles.add(new Obstacle(250, 250+height, 1));
  //obstacles.add(new Obstacle(250, 350+height, 1));
  //obstacles.add(new Obstacle(250, 450+height, 2));
  obstacles.add(new Obstacle(250, 550+height, 2));

  obstacles.add(new Obstacle(350, 50+height, 2));
  obstacles.add(new Obstacle(350, 150+height, 3));
  obstacles.add(new Obstacle(350, 250+height, 2));
  obstacles.add(new Obstacle(350, 350+height, 2));
  //obstacles.add(new Obstacle(350, 450+height, 2));
  obstacles.add(new Obstacle(350, 550+height, 2));

  obstacles.add(new Obstacle(450, 50+height, 3));
  obstacles.add(new Obstacle(450, 150+height, 3));
  obstacles.add(new Obstacle(450, 250+height, 3));
  obstacles.add(new Obstacle(450, 350+height, 3));
  //obstacles.add(new Obstacle(450, 450+height, 3));
  obstacles.add(new Obstacle(450, 550+height, 3));

  obstacles.add(new Obstacle(550, 50+height, 3));
  obstacles.add(new Obstacle(550, 150+height, 3));
  obstacles.add(new Obstacle(550, 250+height, 3));
  obstacles.add(new Obstacle(550, 350+height, 3));
  //obstacles.add(new Obstacle(550, 450+height, 3));
  obstacles.add(new Obstacle(550, 550+height, 3));
  
  obstacles.add(new Obstacle(650, 50+height, 1));
  obstacles.add(new Obstacle(650, 150+height, 1));
  obstacles.add(new Obstacle(650, 250+height, 1));
  obstacles.add(new Obstacle(650, 350+height, 1));
  //obstacles.add(new Obstacle(650, 450+height, 1));
  obstacles.add(new Obstacle(650, 550+height, 1));

  obstacles.add(new Obstacle(750, 50+height, 1));
  obstacles.add(new Obstacle(750, 150+height, 1));
  obstacles.add(new Obstacle(750, 250+height, 1));
  obstacles.add(new Obstacle(750, 350+height, 1));
  //obstacles.add(new Obstacle(750, 450+height, 1));
  obstacles.add(new Obstacle(750, 550+height, 1));

  e = new AICar(115, 120);
  enemies.add(e);

  for (int i = 0; i < 2; i++) {
    enemies.add(new AICar(115, 120));
  }
}

void draw() {

  if (stage==1) {
    if (keyPressed) stage = 2;
  }
  if (stage==2) {
    //println(box2d.getBodyPixelCoord(b.body).x + " " + box2d.getBodyPixelCoord(b.body).y);
    updateAll();
    if (box2d.getBodyPixelCoord(b.body).x > 790) {
      clearScreen();
      stage = 3;
      //translate(600,0);
      for (Obstacle obst : obstacles) obst.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(obst.body.getWorldCenter()).x-width, box2d.coordWorldToPixels(obst.body.getWorldCenter()).y)), obst.body.getAngle());
      for (CircleObst obst : circleObstacles) obst.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(obst.body.getWorldCenter()).x-width, box2d.coordWorldToPixels(obst.body.getWorldCenter()).y)), obst.body.getAngle());
      b.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(b.body.getWorldCenter()).x-width, box2d.coordWorldToPixels(b.body.getWorldCenter()).y)), -1*b.rotation);
      for (AICar a : enemies) a.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(a.body.getWorldCenter()).x-width, box2d.coordWorldToPixels(a.body.getWorldCenter()).y)), -1*a.rotation);
      p1.pos.x = p1.pos.x-width;
      for (int i = 0; i < p1.checkPoints.length;i++) p1.checkPoints[i][0].x-=width;
    }
  }
  if (stage == 3) {
    updateAll();
    if (box2d.getBodyPixelCoord(b.body).y > 590) {
      clearScreen();
      stage = 4;
      //translate(600,0);
      for (Obstacle obst : obstacles) obst.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(obst.body.getWorldCenter()).x, box2d.coordWorldToPixels(obst.body.getWorldCenter()).y-height)), obst.body.getAngle());
      for (CircleObst obst : circleObstacles) obst.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(obst.body.getWorldCenter()).x, box2d.coordWorldToPixels(obst.body.getWorldCenter()).y-height)), obst.body.getAngle());
      b.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(b.body.getWorldCenter()).x, box2d.coordWorldToPixels(b.body.getWorldCenter()).y-height)), -1*b.rotation);
      for (AICar a : enemies) a.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(a.body.getWorldCenter()).x, box2d.coordWorldToPixels(a.body.getWorldCenter()).y-height)), -1*a.rotation);
      p1.pos.y = p1.pos.y-height;
      for (int i = 0; i < p1.checkPoints.length;i++) p1.checkPoints[i][0].y-=height;
    }
  }
  if (stage == 4) {
    updateAll();
    if (box2d.getBodyPixelCoord(b.body).x < 10) {
      clearScreen();
      stage = 5;
      //translate(600,0);
      for (Obstacle obst : obstacles) obst.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(obst.body.getWorldCenter()).x+width, box2d.coordWorldToPixels(obst.body.getWorldCenter()).y)), obst.body.getAngle());
      for (CircleObst obst : circleObstacles) obst.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(obst.body.getWorldCenter()).x+width, box2d.coordWorldToPixels(obst.body.getWorldCenter()).y)), obst.body.getAngle());
      b.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(b.body.getWorldCenter()).x+width, box2d.coordWorldToPixels(b.body.getWorldCenter()).y)), -1*b.rotation);
      for (AICar a : enemies) a.body.setTransform(new Vec2(box2d.coordPixelsToWorld(box2d.coordWorldToPixels(a.body.getWorldCenter()).x+width, box2d.coordWorldToPixels(a.body.getWorldCenter()).y)), -1*a.rotation);
      p1.pos.x = p1.pos.x+width;
      for (int i = 0; i < p1.checkPoints.length;i++) p1.checkPoints[i][0].x+=width;
    }
  }
  if (stage == 5) {
    updateAll();
  }
}

void updateAll() {
  background(255);
  //println(box2d.coordWorldToPixels(e.body.getWorldCenter()).x);

  // We must always step through time!
  box2d.step();

  b.display();

  for (CircleObst obs : circleObstacles) {
    obs.display();
  }

  for (Obstacle obs : obstacles) {
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
    //ellipse(p1.pos.x, p1.pos.y, 20, 20);
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