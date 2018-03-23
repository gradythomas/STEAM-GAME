public class Track {
  private int x;
  private int y;
  private PImage tImage;
  public Track(int x, int y) {
    this.x = x;
    this.y = y;
    tImage = loadImage("Track.png");
    tImage.resize(100, 100);
  }
  public Track(int x, int y, int borders) { // borders checks to see if there are surrounding water to load a border for visual effects
    this(x, y);
    if (borders == 1) { //signifies right and left
      tImage = loadImage("TrackRightAndLeft.png");
    } else if ( borders == 2) {
      tImage = loadImage("TrackTopAndBottom.png");
    } else if (borders == 3) {
      tImage = loadImage("TrackTop.png");
    }
    tImage.resize(100,100);
  }
  public void display() {
    imageMode(CENTER);
    image(tImage, x, y);
    imageMode(CORNER);
    
  }
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public void setX(int x) {
    this.x = x;
  }
  public void setY(int y) {
    this.y = y;
  }
}