import ddf.minim.*;
import processing.video.*;

Movie myMovie;

Minim minim;
AudioInput in;

color paint;

void setup()
{
  colorMode(HSB, 255);
  size(720, 482, P3D);

  minim = new Minim(this);
  minim.debugOn();

  // get a line in from Minim, default bit depth is 16
  in = minim.getLineIn(Minim.STEREO, 512);

  thread("movieEvent");
  myMovie = new Movie(this, "Test01-low.mov");

  myMovie.play();
  myMovie.loop();

  noCursor();
}

void draw()
{
  background(0);
  image(myMovie, width/2-480, height/2-270);

  // draw the waveforms
  for (int i = 0; i < in.bufferSize () - 1; i++)
  { 
    paint = color(in.right.get(i+1)*200, 255, 255, in.right.get(i+1)*100);
    fill(paint);
    noStroke();
    ellipse(random(0, width), random(0, height), 3*(in.right.get(i+1)*30), 3*(in.left.get(i+1)*30));
  }
}

void stop()
{
  in.close();
  minim.stop();
  super.stop();
}

void movieEvent(Movie m) {
  m.read();
}
