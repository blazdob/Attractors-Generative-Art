void handleStateSeeQiChen() {
  scale(5,5,5);
  background(0);

  if (swchQiChen) {
    if (musicStart) {
      music.loop();
      freq = amp.analyze();
      musicStart = false;
      cam.lookAt(900,900,2500,400);
    } else {
      amp.input(in);
      in.start();
      freq = amp.analyze()*100;
      cam.setDistance(400);
    }
    swchQiChen = false;
  }
  if (musicPlaying) {
    freq = amp.analyze();
  } else {
    freq = amp.analyze()*20;
  }
  println(freq);
  
  //Calculation of the attractor
  float dt = 0.001;
  float dx = (alfa*(y-x) + y*z)*dt;
  float dy = (r*x + y - x*z)*dt;
  float dz = (x*y - beta*z)*dt;
  x = x + dx;
  y = y + dy;
  z = z + dz;
  
  //Point Setup
  point.add(new PVector(x, y, z));
  point1.add(new PVector(x, z, y));
  point2.add(new PVector(y, x, z));
  point3.add(new PVector(y, z, x));
  point4.add(new PVector(z, x, y));
  point5.add(new PVector(z, y, x));
  
  
  
  stroke(255);
  noFill();
  
  
  //Camera movement
  timePassed = abs(LastUpdate - millis());
  if ( freq >= 0.5 && timePassed > 1000) {
    cameraMovement(Long.parseLong(str(parseInt(1500/freq))));
    LastUpdate = millis();
   }
  
  
  //Drawing
  float hu = 0;
  float bu = 150;
  out = drawShape(point,bu,hu);
  out = drawShape(point1,bu,hu);
  out = drawShape(point2,bu,hu);
  out = drawShape(point3,bu,hu);
  out = drawShape(point4,bu,hu);
  out = drawShape(point5,bu,hu);
  //
} // func
