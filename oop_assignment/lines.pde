public class lines extends shapes {

  void giveBirth() {
    if (activated == true) {
      for (int o = 0; o < 2; o++) {
        trans = trans - o;
      }
      paint = color(hue, 200, bright, trans);
      strokeWeight(.5);
      stroke(paint);

      pushMatrix();
      translate(width, height);
      rotate(radians(rotation));
      line(xPos1, yPos1, xPos2, yPos2);
      popMatrix();
    }
  }
}
