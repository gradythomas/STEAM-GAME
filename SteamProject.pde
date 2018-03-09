

int x = 0;
Car racecar;
AICar enemy;
void setup() {
  size(1000,700);
  rectMode(CENTER);
  racecar = new Car(50,50);
  enemy = new AICar(70,70);
}


void draw() {
  background(0);
  racecar.update();
  enemy.update(racecar);
  
}
