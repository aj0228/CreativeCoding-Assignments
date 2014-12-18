public class rectangles extends shapes {

  void giveBirth() {
    if (activated == true) {
      noStroke();
      for (int o = 0; o < 2; o++) {
        trans = trans-o;
      }
      paint = color(hue, 200, bright, trans);
      fill(paint);
      pushMatrix();
      translate(width/2, height/2);
      rotate(radians(rotation));
      rect(xPos, yPos, 5+size, 5+size);
      popMatrix();
    }
  }
}
