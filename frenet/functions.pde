PVector gamma(float t) {
  return new PVector(100 * cos(PI * t / 10), 100 * sin(PI * t / 10), 200 * cos(PI * t / 20));
}

PVector dotGamma(float t) {
  return new PVector(- 10 * PI * sin(PI * t / 10), 10 * PI * cos(PI * t / 10), -10 * PI * sin(PI * t / 20));
}

PVector ddotGamma(float t) {
  return new PVector(- PI * PI * cos(PI * t / 10), - PI * PI * sin(PI * t / 10), -HALF_PI * PI * cos(PI * t / 20));
}

void cylinder(float r, float h) {
  int sides = 6;
  float angle = 360 / sides;

  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, h);
  }
  endShape(CLOSE);

  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, 0);
  }
  endShape(CLOSE);

  beginShape(TRIANGLE_STRIP);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, h);
    vertex( x, y, 0);
  }
  endShape(CLOSE);
}

void cone(float r, float h) {
  int sides = 6;
  float angle = 360 / sides;

  beginShape();
  for (int i = 0; i < sides; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex( x, y, 0);
  }
  endShape(CLOSE);

  beginShape(TRIANGLE_FAN);
  vertex(0, 0, h);
  for (int i = 0; i < sides + 1; i++) {
    float x = cos( radians( i * angle ) ) * r;
    float y = sin( radians( i * angle ) ) * r;
    vertex(x, y, 0);
  }
  endShape(CLOSE);
}

void arrow() {
  pushMatrix();
  cylinder(5, 50);
  translate(0, 0, 50);
  cone(10, 20);
  popMatrix();
}

float[] getAngles(Frenet frame) {
  
  PVector X = frame.X;
  PVector Y = frame.Y;
  PVector Z = frame.Z;
  
  float theta = asin(-X.z);
  float phi = asin(Y.z / sqrt(1 - X.z * X.z));
  float psi = asin(X.y / sqrt(1 - X.z * X.z));
  
  return new float[]{theta, phi, psi};
}