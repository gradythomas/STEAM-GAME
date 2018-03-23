class Point {

  float speed = 5;
  int m = 0;
  int j = 1;
  boolean lap = false;

  PVector[][] checkPoints = {{new PVector(440, 140), new PVector(0, speed)}, 
    {new PVector(440, 460), new PVector (speed, 0)}, 
    {new PVector(150+800, 460), new PVector (0, -speed)}, 
    {new PVector(150+800, 120), new PVector (speed, 0)}, 
    {new PVector(460+800, 120), new PVector (0, speed)}, 
    {new PVector(460+800, 500), new PVector (0, speed)}, 
    {new PVector(460+800, 170+600), new PVector (-speed, 0)}, 
    {new PVector(130+800, 170+600), new PVector (0, speed)}, 
    {new PVector(130+800, 470+600), new PVector (-speed, 0)}, 
    {new PVector(220, 470+600), new PVector (0, -speed)}, 
    {new PVector(220, 120+600), new PVector (-speed, 0)}, 
    {new PVector(610-800, 120+600), new PVector (0, speed)}, 
    {new PVector(610-800, 480+600), new PVector (-speed, 0)}, 
    {new PVector(130-800, 480+600), new PVector (0, -speed)}, 
    {new PVector(130-800, 140+600), new PVector (speed, 0)}, 
    {new PVector(460-800, 140+600), new PVector (0, -speed)}, 
    {new PVector(460-800, 430), new PVector (-speed, 0)}, 
    {new PVector(240-800, 430), new PVector (0, -speed)}, 
    {new PVector(240-800, 40), new PVector (speed, 0)}, 
    {new PVector(660-800, 40), new PVector (0, speed)}, 
    {new PVector(660-800, 140), new PVector (speed, 0)}};

  int[] hitPts = new int[checkPoints.length];

  PVector pos = new PVector (150, 140);
  PVector vel = new PVector (speed, 0);
  boolean stopped = false;
  ;
  Point() {
    for (int i = 0; i < hitPts.length; i++) {
      hitPts[i] = 0;
    }
  }
  void update() {
    pos.add(vel);
    for (int i = 0; i < checkPoints.length; i++) {
      if (pos.equals(checkPoints[i][0])) {
        vel.set(checkPoints[i][1]);
        hitPts[i] = 1;
      }
    }
  }

  void stop() {
    stopped = true;
    m = millis();
  }
  /*  void setSpeed(int difficultlyLevel) {
   for (int i = 0; i < 11; i++) {
   if (difficultyLevel == 1) 
   checkPoints[i][0].mult(0.8);
   else if (difficultyLevel == 3)
   checkPoints[i][0].mult(1.5);
   }
   } */
}
