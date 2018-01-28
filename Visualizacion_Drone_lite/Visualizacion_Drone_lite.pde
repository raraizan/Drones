//import peasy.*;
import processing.serial.*;

Serial myPort;
//PeasyCam cam;

// Data samples
int actualSample = 0;
int maxSamples = 400;
int sampleStep = 1;
boolean hasData = false;

// Data for gyroscope X, Y, Z
float[][] gyroscopeValues = new float[3][maxSamples];

// Data for gyroscope Pitch, Roll, Yaw
float[][] pyrValues = new float[3][maxSamples];

void setup()
{
  size(500, 500, P3D);
  background(0);

  // Serial
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.bufferUntil(10);

  //cam = new PeasyCam(this, 500);
}

void draw()
{
  if (!hasData) return;
  //drawRotationCube(480, 15);


  background(0);
  translate(width/2, width/2, -width+30);
  stroke(255);
  line( 0, 0, -width, 0, 0, width);
  line( 0, -width, 0, 0, width, 0);
  line( -10, width, 0, 10, width, 0);
  line( -50, 0, width, 50, 0, width);
  rotateX(radians(pyrValues[0][actualSample-1]));
  rotateZ(radians(pyrValues[1][actualSample-1])); 
  rotateY(radians(pyrValues[2][actualSample-1]));
  fill(150, 150, 200);
  drone(width);
}

void nextSample(float[][] chart)
{
  for (int j = 0; j < chart.length; j++)
  {
    float last = chart[j][maxSamples-1];

    for (int i = 1; i < maxSamples; i++)
    {
      chart[j][i-1] = chart[j][i];
    }

    chart[j][(maxSamples-1)] = last;
  }
}

void serialEvent (Serial myPort)
{
  String inString = myPort.readStringUntil(10);

  if (inString != null)
  {
    inString = trim(inString);
    String[] list = split(inString, ':');
    String testString = trim(list[0]);

    if (list.length != 6) return;

    for (int j = 0; j < gyroscopeValues.length; j++)
    {
      gyroscopeValues[j][actualSample] = (float(list[j]) / 57.2957795);
    }

    for (int j = 0; j < pyrValues.length; j++)
    {
      pyrValues[j][actualSample] = (float(list[j+3]));
    }

    if (actualSample > 1)
    {
      hasData = true;
    }

    if (actualSample == (maxSamples-1))
    {
      nextSample(gyroscopeValues);
      nextSample(pyrValues);
    } else
    {
      actualSample++;
    }
  }
}

void drone(float R) {

  float r = R / 5;
  float h = R / 10;
  stroke(0);
  fill(255);
  beginShape(TRIANGLE_FAN);
  vertex(0, -h, -r * .8);
  for (int i = 0; i <= 4; i++) {
    vertex(r * cos(HALF_PI * i), 0, r * sin(HALF_PI * i));
    vertex(R * cos(HALF_PI * (i + .5)), 0, R * sin(HALF_PI * (i + .5)));
  }
  endShape(CLOSE);
  fill(255, 0, 0);
  beginShape(TRIANGLE_FAN);
  vertex(0, h, -r * .8);
  for (int i = 0; i <= 4; i++) {
    vertex(r * cos(HALF_PI * i), 0, r * sin(HALF_PI * i));
    vertex(R * cos(HALF_PI * (i + .5)), 0, R * sin(HALF_PI * (i + .5)));
  }
  endShape(CLOSE);
}