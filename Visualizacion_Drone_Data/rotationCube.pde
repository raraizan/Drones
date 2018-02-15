void initRotationCube() {
  pgRotationCube = createGraphics(250, 250, P3D);
}


void drawRotationCube(int x, int y)
{
  pgRotationCube.beginDraw();
  pgRotationCube.lights();
  pgRotationCube.ortho();
  pgRotationCube.background(0);
  pgRotationCube.translate(pgRotationCube.width/2, pgRotationCube.width/2, -pgRotationCube.width+30);
  
  // Estas rotaciones estan mal
  pgRotationCube.rotateX(radians(pyrValues[0][actualSample-1]));
  pgRotationCube.rotateZ(radians(pyrValues[1][actualSample-1])); 
  pgRotationCube.rotateY(radians(pyrValues[2][actualSample-1]));
  
  pgRotationCube.box(100);
  pgRotationCube.endDraw();
  image(pgRotationCube, x, y);
}