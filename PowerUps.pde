public class PowerUp {
  Body body;
  float w;
  float h;
  float rotation;
  PVector pos, vel;
  float mag;
  float x;
  float y;
  int r = 20;
  boolean isShown;
  int colorR;
  int colorG;
  int colorB;
  char type;//signifies type of power up

  // Constructor
  PowerUp(float x, float y) {
    w = 20;
    h = 20;
    // Add the box to the box2d world
    this.x=x;
    this.y=y;
    mag = 0;
    pos = new PVector(x,y);
    vel = new PVector(0.0,0.0);
    isShown = true;
    colorR = 0;
    colorG = 0;
    colorB = 0;
    type = '0';//signifies no type
  }

  // Drawing the box
  void display() {
    stroke(0);
    fill(colorR, colorG, colorB);
    ellipse(x, y, r*2, r*2);
  }
  
  void highlight() {
    fill(colorR, colorG, colorB);
  }
  
  public boolean getIsShown() {
    return this.isShown;
  }
  
  public void setIsShown(boolean isShown) {
    this.isShown = isShown;
  }
  
  public char getType() {
    return this.type;
  }
}