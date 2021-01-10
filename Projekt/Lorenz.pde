void handleStateSeeLorenz() {
  scale(50,50,50);
  background(0);

  if (swchLorenz) {
    if (musicStart) {
      music.loop();
      musicStart = false;
      cam.lookAt(900,900,2500,400);
    } else {
      amp.input(in);
      in.start();
      
      cam.setDistance(400);
    }
    swchLorenz = false;
  }
  println(musicPlaying);
  if (musicPlaying) {
    freq = amp.analyze();
  } else {
    freq = amp.analyze()*20;
  }
  println(freq);
  //Calculation of the attractor
  float dt = 0.008;
  float dx = (a * (y - x))*dt;
  float dy = (x * (b - z) - y)*dt;
  float dz = (x * y - c * z)*dt;
  x = x + dx;
  y = y + dy;
  z = z + dz;
  
  point.add(new PVector(x, y, z));
  point1.add(new PVector(x, z, y));
  point2.add(new PVector(y, x, z));
  point3.add(new PVector(y, z, x));
  point4.add(new PVector(z, x, y));
  point5.add(new PVector(z, y, x));
  
  stroke(255);
  noFill();
  
  
  ////Camera movement
  timePassed = abs(LastUpdate - millis());
  if ( freq >= 0.2 && timePassed > 1000) {
    cameraMovement(Long.parseLong(str(parseInt(1500/freq))));
    LastUpdate = millis();
   }
  
  
  //Drawing
  float hu = 0;
  float bu = 150;
  out = drawShape(point,bu,hu);
  out = drawShape(point1,out[1],out[0]);
  out = drawShape(point2,out[1],out[0]);
  out = drawShape(point3,out[1],out[0]);
  out = drawShape(point4,out[1],out[0]);
  out = drawShape(point5,out[1],out[0]);
  
} // func
