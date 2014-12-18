import ddf.minim.analysis.*;
import ddf.minim.*;
import ddf.minim.signals.*;

int numTriangles;
triangles[] numT;

int numDots;
dots[] numD;

int numLines;
lines[] numL;

int numRectangles;
rectangles[] numR;


int drawTriangles = 220;
int drawRectangles = 220;
int drawLines = 300;
int drawDots = 200;
int changeBGcolor =100;

int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;

PFont f;
String typing = "";

Minim minim;
AudioOutput out;

ArrayList<MovingShapes> shapeList = new ArrayList<MovingShapes>();

void setup() {
  size(1024, 768, P3D);

  colorMode(HSB, 255);
  c1 = color(171, 28, 90);
  c2 = color(245, 100, 93);
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);

  shapeList.add(new dots());
  shapeList.add(new lines());
  shapeList.add(new rectangles());
  shapeList.add(new triangles());
}

void draw() {
  background(255, 255, 255, 50);
  setGradient(0, 0, width, height, c1, c2, X_AXIS);
  smooth(10);
  textFont(f);
  textSize(50);
  noStroke();
  fill(255);
  text(typing, 10, height-10);  
  
  // Once the shapes have a shared interface they can all be drawn together
  for (MovingShapes m : shapeList) {
    m.giveBirth();
  }  
  
  for (int i = 0; i < changeBGcolor; i++) {
    c1=c1;
  }
  for (int i = 0; i < changeBGcolor; i++) {
    c2=c2;
  }
  

}

class PianoNote implements AudioSignal
{
  private float freq;
  private float level;
  private float alph;
  private SineWave sine;
  PianoNote(float pitch, float amplitude)
  {
    freq = pitch;
    level = amplitude;
    sine = new SineWave(freq, level, out.sampleRate());
    alph = 0.9; // Decay constant for the envelope
    out.addSignal(this);
  }
  void updateLevel()
  {
    // Called once per buffer to decay the amplitude away
    level = level * alph;
    sine.setAmp(level);
    // This also handles stopping this oscillator when its level is very low.
    if (level < 0.01) {
      out.removeSignal(this);
    }
    // this will lead to destruction of the object, since the only active
    // reference to it is from the LineOut
  }
  void generate(float [] samp)
  {
    // generate the next buffer's worth of sinusoid
    sine.generate(samp);
    // decay the amplitude a little bit more
    updateLevel();
  }
  // AudioSignal requires both mono and stereo generate functions
  void generate(float [] sampL, float [] sampR)
  {
    sine.generate(sampL, sampR);
    updateLevel();
  }
}

void keyPressed()
{
  SineWave mySine;
  PianoNote newNote;
  // Map the key to a pitch (in Hz), and instantiate the Note object
  float pitch = 0;

  switch(key) {
  case 'z': 
    pitch = 262;  
    for (int i = 0; i < 100; i++) {
      numD[i].activated=true;
    }
    //drawDots+=10;

    for (int i = 0; i < changeBGcolor; i++) {
      c2 +=40;
    }  
    typing = "C";
    break;

  case 's': 
    pitch = 277; 
    for (int i = 0; i < numTriangles; i++) {
      numT[i].rotation +=20;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "C#";
    break;

  case 'x': 
    pitch = 294; 
    for (int i = 0; i < drawDots; i++) {
      numD[i].rotation +=20;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "D";
    break;

  case 'd': 
    pitch = 311; 
    for (int i = 0; i < numTriangles; i++) {
      numT[i].hue +=20;
    }

    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "D#";
    break;
  case 'c': 
    pitch = 330; 

    for (int i = 0; i < drawLines; i++) {
      numL[i].activated=true;
    }
    drawLines+=5;

    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "E";
    break;
  case 'v': 
    pitch = 349; 
    for (int i = 0; i < drawRectangles; i++) {
      numR[i].xPos-=200;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "F";
    break;
  case 'g': 
    pitch = 370; 
    for (int i = 0; i < numTriangles; i++) {
      numT[i].bright +=80;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "F#";
    break;
  case 'b': 
    pitch = 392; 
    for (int i = 0; i < numTriangles; i++) {
      numT[i].bright +=20;
    }
    for (int i = 0; i < numTriangles; i++) {
      numT[i].xPos +=100;
    }

    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "G";
    break;
  case 'h': 
    pitch = 415; 
    for (int i = 0; i < numTriangles; i++) {
      numT[i].xPos -=100;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "G#";
    break;
  case 'n': 
    pitch = 440; 
    for (int i = 0; i < numTriangles; i++) {
      numT[i].size+=20;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "A";
    break;
  case 'j': 
    pitch = 466; 
    for (int i = 0; i < numTriangles; i++) {
      numT[i].rotation +=20;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "A#";
    break;
  case 'm': 
    pitch = 494; 
    for (int i = 0; i < numTriangles; i++) {
      numT[i].size-=20;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "B";
    break;
  case ',': 
    pitch = 523; 
    for (int i = 0; i < drawRectangles; i++) {
      numR[i].activated=true;
    }
    drawRectangles+=10;
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "C";
    break;
  case 'l': 
    pitch = 554; 
    for (int i = 0; i < numRectangles; i++) {
      numR[i].rotation +=50;
    }
    for (int i = 0; i < changeBGcolor; i++) {
      c1 +=40;
    }
    typing = "C#";
    break;
  case '.': 
    pitch = 587; 
    for (int i = 0; i < drawTriangles; i++) {
      numT[i].activated=true;
    }
    drawTriangles+=10;

    for (int i = 0; i < changeBGcolor; i++) {
      c2 +=40;
    }
    typing = "D";
    break;

  case ';': 
    pitch = 622; 
    for (int i = 0; i < numDots; i++) {
      numD[i].size +=1;
    }

    for (int i = 0; i < changeBGcolor; i++) {
      c2 +=40;
    }
    typing = "D#";
    break;

  case '/': 
    pitch = 659; 
    for (int i = 0; i < drawDots; i++) {
      numD[i].activated=true;
    }
    drawDots+=10;

    for (int i = 0; i < changeBGcolor; i++) {
      c2 -=40;
    }
    typing = "E";
    break;
  }
  if (pitch > 0) {
    newNote = new PianoNote(pitch, 0.2);
  }
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == X_AXIS) {
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

void stop()
{
  out.close();
  minim.stop();
  super.stop();
}
