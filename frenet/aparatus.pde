class Frenet {
  PVector X, Y, Z, pos;
  float[] ang;

  Frenet() {
    ang  = new float[]{0, 0, 0};
    X = new PVector(1, 0, 0);
    Y = new PVector(0, 1, 0);
    Z = new PVector(0, 0, 1);

    pos = new PVector(0, 0, 0);
  }

  void display() {
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);

    rotateZ(ang[1]);
    rotateX(ang[0]);
    rotateZ(ang[2]);

    fill(0, 0, 255);
    arrow();

    fill(255, 0, 0);
    pushMatrix();
    rotateY(HALF_PI);
    arrow();
    popMatrix();

    fill(0, 255, 0);
    pushMatrix();
    rotateX(-HALF_PI);
    arrow();
    popMatrix();

    fill(255);
    popMatrix();
  }

  void update(float[] ang_, PVector pos_) {
    ang = ang_;
    X = new PVector(cos(ang[1]) * cos(ang[0]), cos(ang[1]) * sin(ang[0]) * sin(ang[2]) - sin(ang[1]) * cos(ang[2]), cos(ang[1]) * sin(ang[0]) * cos(ang[2]) + sin(ang[1]) * sin(ang[2]));
    Y = new PVector(sin(ang[1]) * cos(ang[0]), sin(ang[1]) * sin(ang[0]) * sin(ang[2]) + cos(ang[1]) * cos(ang[2]), sin(ang[1]) * sin(ang[0]) * cos(ang[2]) - cos(ang[1]) * sin(ang[2]));
    Z = new PVector(              sin(ang[0]), cos(ang[0]) * sin(ang[2]), cos(ang[0]) * cos(ang[2]));

    pos = pos_.copy();
  }

  void update(PVector X_, PVector Y_, PVector Z_, PVector pos_) {
    X = X_;
    Y = Y_;
    Z = Z_;
    float theta = atan2(-X.z, sqrt(1 - X.z * X.z));
    float phi = asin(Y.z / sqrt(1 - X.z * X.z));
    float psi = asin(X.y / sqrt(1 - X.z * X.z));

    ang = new float[]{theta, psi, phi};
    pos = pos_.copy();
  }
}