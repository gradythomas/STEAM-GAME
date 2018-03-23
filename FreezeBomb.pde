// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

class FreezeBomb extends PowerUp {

  // Constructor
  FreezeBomb(float x, float y) {
    super(x,y);
    colorR = 127;
    colorG = 223;
    colorB = 244;
    type = 'f';
  }

  // Drawing the box
  void display() {
    stroke(0);
    fill(colorR, colorG, colorB);
    ellipse(x, y, r*2, r*2);
  }
  
  void highlight() {
    fill(500);
  }
}