class Axes {
  boolean on;

  Axes() {
    on = true;
  }

  void display() {
    if (this.on) {
      stroke(255);
      strokeWeight(1);
      line(-250, 0, 0, 250, 0, 0);
      line(0, -250, 0, 0, 250, 0);
      line(0, 0, -250, 0, 0, 250);
    }
  }
}