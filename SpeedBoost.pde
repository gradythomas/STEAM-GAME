// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

class SpeedBoost extends PowerUp {


  // Constructor
  SpeedBoost(float x, float y) {
    super(x,y);
    colorR = 38;
    colorG = 224;
    colorB = 69;
    type = 'b';// b for boost
  }

  // Drawing the box
  void display() {
    stroke(0);
    fill(500);
    ellipse(x, y, r*2, r*2);
  }
  
  void highlight() {
    fill(500);
  }
}