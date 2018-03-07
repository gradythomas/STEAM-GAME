
int x = 0;
Car racecar;

void setup() {
  size(1000,700);
  rectMode(CENTER);
  racecar = new Car(50,50);
}


void draw() {
  background(0);
  println(key);
  racecar.update();  
}
