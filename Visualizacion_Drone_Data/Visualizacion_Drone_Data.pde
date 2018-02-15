import processing.serial.*;

Serial myPort;

// Data samples
int actualSample = 0;
int maxSamples = 400;
int sampleStep = 1;
boolean hasData = false;

// Charts
PGraphics pgChart;
int[] colors = { #ff4444, #33ff99, #5588ff };
String[] gyroscopeSeries = { "X", "Y", "Z" };
String[] pyrSeries = { "Pitch", "Roll", "Yaw" };

// Data for gyroscope X, Y, Z
float[][] gyroscopeValues = new float[3][maxSamples];

// Data for gyroscope Pitch, Roll, Yaw
float[][] pyrValues = new float[3][maxSamples];

// Rotation Cube
PGraphics pgRotationCube;

void setup() {
  size(755, 550, P2D);
  background(0);

  // Init
  initRotationCube();

  // Serial
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.bufferUntil(10);
}

void draw()
{
  if (!hasData) return;

  drawChart("Gyroscope [rad/sec]", gyroscopeSeries, gyroscopeValues, 10, 10, 200, true, true, -10, 10, 5);
  drawChart("Gyroscope [deg]", pyrSeries, pyrValues, 10, 280, 200, true, true, -180, 180, 30);
  drawRotationCube(480, 15);
}