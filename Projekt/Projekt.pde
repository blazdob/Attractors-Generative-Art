import peasy.*;
import peasy.org.apache.commons.math.geometry.Rotation;
import peasy.org.apache.commons.math.geometry.Vector3D;
import processing.sound.*;

//CAMERA VARIABLES/OBJECTS
PeasyCam cam;
CameraState stateCam;
int UpdateInterval;
int LastUpdate;
boolean finishedRotation;
float timePassed;
float smoothingFactor = 0.25;

//BUTTON VARIABLES/OBJECTS
Button button_Lorenz;  // the button
Button button_QiChen;  // the button
Button Glasba;  // the button
Button button_Back;

//MENU VARIABLES
final int stateMenu= 0;
final int stateSeeLorenz= 1;
final int stateSeeQiChen= 2;
int state = stateMenu;
String tekst_glasba;


//LORENZ attractor data
float a = 10;
float b = 28;
float c = 8.0/3.0;
//QICHEN attractor data
float alfa = 38;
float beta = 8/3;
float r = 80;

//MUSIC VARIABLES AND OBJECTS
float[] out;
float sum;
boolean musicStart = true;
boolean musicPlaying = true;
SoundFile music;
AudioIn in; 
Amplitude amp;
float freq;

//DRAWING VARIABLES
//axis data
float x = 0.1;
float y = 0;
float z = 0;
float w = 0;
ArrayList<PVector> point = new ArrayList<PVector>();
ArrayList<PVector> point1 = new ArrayList<PVector>();
ArrayList<PVector> point2 = new ArrayList<PVector>();
ArrayList<PVector> point3 = new ArrayList<PVector>();
ArrayList<PVector> point4 = new ArrayList<PVector>();
ArrayList<PVector> point5 = new ArrayList<PVector>();
boolean swchLorenz = true;
boolean swchQiChen = true;

PVector axis3 = new PVector(1.0, 0, 0);
float halfh;

void setup() {
  
  halfh = height * 0.5;
  
  //WINDOW SETUP
  size(1820, 980, P3D);
  colorMode(HSB);
  smooth();
  
  //BUTTON SETUP
  button_Lorenz = new Button("Lorenz", 50, 60, 100, 50);
  button_QiChen = new Button("Qi-Wang", 50, 160, 100, 50);
  Glasba = new Button("Glasba/zvok", 50,260,100,50);
  
  //CAMERA SETUP
  cam = new PeasyCam(this, 855,465,0,800);
  cam.setActive(false);
  
  //MUSIC/SOUND SETUP
  music = new SoundFile(this, "Photograph.aiff");  
  amp=new Amplitude(this); 
  in=new AudioIn(this, 0);  
  amp.input(music);
  
  //ANIMATION SETUP
  LastUpdate = millis();
  UpdateInterval = 1000;
  finishedRotation = true;
  
  //MENU SETUP
  tekst_glasba = "Trenutno je aktivna uporaba glasbe v obliki aiff datoteke.";
  
  
}

void draw() {
  // the main routine. It handels the states.
  // runs again and again
  switch (state) {
  case stateMenu:
    cam.setActive(false);
    showMenu();
    break;
  case stateSeeLorenz:
    cam.setActive(true);
    handleStateSeeLorenz();
    break;
  case stateSeeQiChen:
    cam.setActive(true);
    handleStateSeeQiChen();
    break;
  default:
    exit();
    break;
  } // switch
  //
}

// MENU mouse button clicked
void mousePressed()
{
  if (button_Back.MouseIsOver()) {
    state = stateMenu;
    cam.lookAt(0,0,0);
  }
  if (button_Lorenz.MouseIsOver()) {
    state=stateSeeLorenz;
    cam.lookAt(0,0,0);
  }
  if (button_QiChen.MouseIsOver()) {
    state = stateSeeQiChen;
    cam.lookAt(0,0,0);
  }
  if (Glasba.MouseIsOver()) {
    if (musicStart) {
      musicStart = false;
      musicPlaying = false;
      tekst_glasba = "Trenutno je aktivirana uporaba računalniškega zvoka.";
    } else {
      musicStart = true;
      musicPlaying = true;
      tekst_glasba = "Trenutno je aktivna uporaba glasbe v obliki aiff datoteke.";
    }
  }
}

public void cameraMovement(long animationTime) {
  if (state == stateSeeLorenz) {
    stateCam = new CameraState(new Rotation(random(-10,10),random(-10,10),random(-10,10),random(-10,10),true), new Vector3D(random(100,900),random(-400,900),random(0,900)), random(500,1000));
  } else {
    stateCam = new CameraState(new Rotation(random(-10,10),random(-10,10),random(-10,10),random(-10,10),true), new Vector3D(random(100,500),random(-400,500),random(0,500)), random(500,1000));
  }
  cam.setState(stateCam, animationTime);
}


//SHAPE DRAWING
public float[] drawShape( ArrayList<PVector> point, float bu, float hu){
  beginShape();
  for (PVector v : point) {
    stroke(hu, 255, bu);
    if (state == stateSeeLorenz) {
    strokeWeight(0.1);
    } else {
      strokeWeight(0.7);
    }
    vertex(v.x, v.y,v.z);
    //testiranje spreminjanja stroke
    //strokeWeight(norm(amp.analyze(),0,1)-0.2);
    hu += 0.1;
    if (hu > 255) {
      hu = 0;
    }
    
    bu += 0.1;
    if (bu > 255) {
      bu = 20;
    }
  }
  endShape();
  float[] out = new float[2];
  out[0] = hu;
  out[1] = bu;
  return out;
}
