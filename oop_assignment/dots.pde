public class dots extends shapes {

  void giveBirth() {
    if (activated == true) {

      for (int o = 0; o < 2; o++) {
        trans = trans - o;
      }
      paint = color(hue, 200, bright, trans);
      noStroke();
      tint(paint);

      pushMatrix();
      translate(0, 0, 100);
      rotate(radians(rotation));
      ellipse(xPos, yPos, size, size);
      popMatrix();
    }
  }
}
