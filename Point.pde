class Point {

  float speed = 5.75*(float)Math.pow(difficultyFactor, 3);
  int m = 0;
  int j = 1;
  boolean lap = false;

  PVector[][] checkPoints = {{new PVector(438, 140), new PVector(0, speed)}, 
    {new PVector(438, 458), new PVector (speed, 0)}, 
    {new PVector(150+800, 458), new PVector (0, -speed)}, 
    {new PVector(150+800, 122), new PVector (speed, 0)}, 
    {new PVector(462+800, 122), new PVector (0, speed)}, 
    {new PVector(462+800, 500), new PVector (0, speed)}, 
    {new PVector(462+800, 170+600), new PVector (-speed, 0)}, 
    {new PVector(134+800, 170+600), new PVector (0, speed)}, 
    {new PVector(134+800, 470+600), new PVector (-speed, 0)}, 
    {new PVector(220, 470+600), new PVector (0, -speed)}, 
    {new PVector(220, 120+600), new PVector (-speed, 0)}, 
    {new PVector(610-800, 120+600), new PVector (0, speed)}, //
    {new PVector(610-800, 482+600), new PVector (-speed, 0)}, 
    {new PVector(130-800, 480+600), new PVector (0, -speed)}, 
    {new PVector(130-800, 140+600), new PVector (speed, 0)}, //
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
      if (pos.dist(checkPoints[i][0])<7) {
        vel.set(checkPoints[i][1]);
        hitPts[i] = 1;
      }
    }
  }

  void stop() {
    stopped = true;
    m = millis();
  }

  void updatePts() {
    speed = 5.75*(float)Math.pow(difficultyFactor, 3);
    checkPoints[0][1] = new PVector(0, speed);
    checkPoints[1][1] = new PVector (speed, 0);
    checkPoints[2][1] = new PVector (0, -speed);
    checkPoints[3][1] = new PVector (speed, 0);
    checkPoints[4][1] = new PVector (0, speed);
    checkPoints[5][1] = new PVector (0, speed);
    checkPoints[6][1] = new PVector (-speed, 0);
    checkPoints[7][1] = new PVector (0, speed);
    checkPoints[8][1] = new PVector (-speed, 0);
    checkPoints[9][1] = new PVector (0, -speed);
    checkPoints[10][1] = new PVector (-speed, 0);
    checkPoints[11][1] = new PVector (0, speed);//
    checkPoints[12][1] = new PVector (-speed, 0);
    checkPoints[13][1] = new PVector (0, -speed); 
    checkPoints[14][1] = new PVector (speed, 0);//
    checkPoints[15][1] = new PVector (0, -speed);
    checkPoints[16][1] = new PVector (-speed, 0);
    checkPoints[17][1] = new PVector (0, -speed);
    checkPoints[18][1] = new PVector (speed, 0);
    checkPoints[19][1] = new PVector (0, speed);
    checkPoints[20][1] = new PVector (speed, 0);
  }
}