class Point {

  int speed = 10;
  int m = 0;

   PVector[][] checkPoints = {{new PVector(440, 120), new PVector(0, speed)}, 
                              {new PVector(440, 460), new PVector (-speed, 0)},
                              {new PVector(150, 460), new PVector (0, -speed)},
                              {new PVector(150, 120), new PVector (speed, 0)}};

   PVector pos = new PVector (150, 120);
   PVector vel = new PVector (speed, 0);
   boolean stopped = false;;

   void update() {
    pos.add(vel);
    for (int i = 0; i < checkPoints.length; i++) {
      if (pos.equals(checkPoints[i][0])) vel.set(checkPoints[i][1]);
    }
  }

   void stop() {
    stopped = true;
    m = millis();
  }
}