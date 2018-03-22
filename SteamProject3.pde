import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

PImage startscreen;
PFont title;
int screensizex, screensizey, stage;


Box2DProcessing box2d;
Car b;
Point p = new Point();

ArrayList<AICar> enemies = new ArrayList<AICar>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();

void setup() {
  size(600, 600);

  stage = 1;
  screensizex=round(width*.90);
  screensizey=round(height*.90);
  startscreen = loadImage("Racecar.png");
  image(startscreen, 0, 0, screensizex, screensizey);
  title = createFont("font", 1000, true);


  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  // We are setting a custom gravity
  box2d.setGravity(0, 0);

  b = new Car(150, 120);

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
  obstacles.add(new Obstacle(550, 450));
  obstacles.add(new Obstacle(550, 550));
  obstacles.add(new Obstacle(250, 250));
  obstacles.add(new Obstacle(250, 350));
  obstacles.add(new Obstacle(350, 250));
  obstacles.add(new Obstacle(350, 350));
  obstacles.add(new Obstacle(150, 550));
  obstacles.add(new Obstacle(250, 550));
  obstacles.add(new Obstacle(350, 550));
  obstacles.add(new Obstacle(450, 550));
  powerUps.add(new FreezeBomb((int)(300*Math.random()+150), 150));
  powerUps.add(new FreezeBomb((int)(300*Math.random()+150), 450));
  powerUps.add(new SpeedBoost(450, (int)(300*Math.random()+150)));
  for (int i = 0; i < 3; i++) {
    enemies.add(new AICar(115, 120));
  }
}

void draw() {

  if (stage==1)
  {
    textAlign(CENTER);
    text("Car War", 250, 250);
    text("Press 1 for easy mode, 2 for medium mode, 3 for hard mode", 250, 350);
    if (keyPressed) stage = 2;
  }
  if (stage==2)
  {


    background(255);

    // We must always step through time!
    box2d.step();

    b.display();

    for (AICar d3 : enemies) {
      d3.display(p);
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
          p.setIsShown(false);
        } else if (p.getType() == 'b') {
          b.boost();
          p.setIsShown(false);
        }
      }
    }
    if (!p.stopped) {
      p.update();
      ellipse(p.pos.x, p.pos.y, 20, 20);
    }
    if (millis()-p.m > 800) {
      p.stopped = false;
    }
  }
}