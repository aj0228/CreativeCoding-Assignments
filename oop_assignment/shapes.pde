public abstract class shapes implements MovingShapes {

  float xPos, yPos, xPos1, yPos1, xPos2, yPos2, size, hue, bright, rotation;
  int trans;
  color paint; 

  boolean activated;

  public shapes() {
    colorMode(HSB, 255);
    xPos = (int)random(0, width);
    yPos = (int)random(0, height);
    xPos1 = random(0, width);
    yPos1 = random(0, height);
    xPos2 = random(0, height);
    yPos2 = random(0, width);
    size = (int)random(3, 10);
    hue = random(255);
    rotation = random(0, 360);
    trans =255;
    bright = random(255);
    paint = color(random(255), random(255), random(255), trans);
    activated = false;

    numTriangles = 100000;
    numT = new triangles[numTriangles];
    for (int i= 0; i<numTriangles; i++) {
      numT[i] = new triangles();
    }

    numDots = 100000;
    numD = new dots[numDots];
    for (int i= 0; i<numDots; i++) {
      numD[i] = new dots();
    }

    numLines = 100000;
    numL = new lines[numLines];
    for (int i= 0; i<numLines; i++) {
      numL[i] = new lines();
    }

    numRectangles = 100000;
    numR = new rectangles[numRectangles];
    for (int i= 0; i<numRectangles; i++) {
      numR[i] = new rectangles();
    }
  }
  public shapes(int _xPos, int _yPos, int _size) {
    xPos = _xPos;
    yPos = _yPos;
    size = _size;
    paint = color(random(255), random(255), random(255), trans);

    for (int i = 0; i < numTriangles; i++) {

      numT[i].giveBirth();
    }
    for (int i = 0; i < numDots; i++) {
      numD[i].giveBirth();
    }
    for (int i = 0; i < numLines; i++) {
      numL[i].giveBirth();
    }
    for (int i = 0; i < numRectangles; i++) {
      numR[i].giveBirth();
    }
  }
  public shapes(int _xPos, int _yPos, int _size, color _color) {
    xPos = _xPos;
    yPos = _yPos;
    size = _size;
    paint = _color;

    for (int i = 0; i < numTriangles; i++) {

      numT[i].giveBirth();
    }
    for (int i = 0; i < numDots; i++) {
      numD[i].giveBirth();
    }
    for (int i = 0; i < numLines; i++) {
      numL[i].giveBirth();
    }
    for (int i = 0; i < numRectangles; i++) {
      numR[i].giveBirth();
    }
  }

  public abstract void giveBirth();
}
