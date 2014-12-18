public class triangles extends shapes {

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
      triangle(xPos, yPos, xPos+10+size, yPos-10+size, xPos+20+size, yPos+10+size);
      popMatrix();
    }
  }
}
