import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

boolean hatClicked = false;

PImage hat, beard, backgroundImage, backgroundReplace;

float threshold = 80;

void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 

  //thread("captureEvent");

  video.start();

  backgroundImage = createImage(video.width, video.height, RGB);
  backgroundReplace = loadImage("background.jpg" );
  hat = loadImage("christmas-hat.png");
  beard = loadImage("beard.png");
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  image(video, 0, 0);

  noFill();
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  loadPixels();
  video.loadPixels(); 
  backgroundImage.loadPixels();

  for (int x= 0; x <video.width; x++) {
    for (int y = 0; y<video.height; y++) {
      int loc = x + y*video.width; 
      color fgColor = video.pixels[loc]; 

      color bgColor = backgroundImage.pixels[loc];

      float r1 = red(fgColor);
      float g1 = green(fgColor);
      float b1 = blue(fgColor);
      float r2 = red(bgColor);
      float g2 = green(bgColor);
      float b2 = blue(bgColor);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      if (diff > threshold) {
        pixels[loc] = fgColor;
      } else {
        pixels[loc] = backgroundReplace.pixels[loc];
      }
    }
    updatePixels();
  }
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    image(hat, faces[i].x-80, faces[i].y-170, faces[i].width-50, faces[i].height-50);
    //image(beard, faces[i].x, faces[i].y+100, faces[i].width, faces[i].height);
  }
}
void mousePressed() {
  backgroundImage.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  backgroundImage.updatePixels();
}

void captureEvent(Capture c) {
  c.read();
}
