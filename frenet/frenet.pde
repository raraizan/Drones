import peasy.*;

Axes ejes;
Frenet aparato;
PeasyCam cam;
float t = 0;

void setup() {
  size(500, 500, P3D);
  cam = new PeasyCam(this, 500);
  ejes = new Axes();
  aparato = new Frenet();
}


void draw() {
  background(0);
  //rotateX(QUARTER_PI);
  //rotateZ(QUARTER_PI);

  PVector pos = gamma(t), T, N, B; 

  T = dotGamma(t).normalize();
  N = ddotGamma(t).normalize();
  B = new PVector();
  PVector.cross(T, N, B);


  aparato.update(T, N, B, pos);

  stroke(255);
  noFill();

  pushMatrix();
  line(0, 0, 0, pos.x, pos.y, pos.z);
  translate(pos.x, pos.y, pos.z);
  sphere(5);
  popMatrix();

  beginShape();
  for (float t_0 = 0; t_0 < 40; t_0 += .5) vertex(gamma(t_0).x, gamma(t_0).y, gamma(t_0).z);
  endShape(CLOSE);

  aparato.display();
  ejes.display();

  t += .1;
}