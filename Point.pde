class Point {

  int speed = 5;
  int m = 0;
  int j = 1;

   PVector[][] checkPoints = {{new PVector(440, 120), new PVector(0, speed)}, 
                            {new PVector(440, 460), new PVector (speed, 0)},
                            {new PVector(150+800, 460), new PVector (0, -speed)},
                            {new PVector(150+800, 120), new PVector (speed, 0)},
                            {new PVector(460+800, 120), new PVector (0, speed)},
                            {new PVector(460+800, 500), new PVector (0, speed)},
                            {new PVector(460+800, 130+600), new PVector (-speed, 0)},
                            {new PVector(170+800, 130+600), new PVector (0, speed)},
                            {new PVector(170+800, 470+600), new PVector (-speed, 0)},
                            {new PVector(270, 470+600), new PVector (0, -speed)},
                            {new PVector(270, 160+600), new PVector (-speed, 0)}};
                            
   int[] hitPts = new int[checkPoints.length];

   PVector pos = new PVector (150, 120);
   PVector vel = new PVector (speed, 0);
   boolean stopped = false;;
   Point() {
     for (int i = 0; i < hitPts.length;i++) {
       hitPts[i] = 0;
     }
   }
   void update() {
    pos.add(vel);
    println(checkPoints[2][0].x);
    for (int i = j-1; i < j; i++) {
      if (hitPts[i] == 0 && pos.equals(checkPoints[i][0])) {
        vel.set(checkPoints[i][1]);
        j++;
        hitPts[i] = 1;
      }
      if (j > checkPoints.length) j = checkPoints.length;
    }
  }

   void stop() {
    stopped = true;
    m = millis();
  }
}