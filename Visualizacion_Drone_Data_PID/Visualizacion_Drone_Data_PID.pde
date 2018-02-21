import processing.serial.*;

Serial myPort;

// Data samples
int actualSample = 0;
int maxSamples = 400;
boolean hasData = false;

// Charts
PGraphics pgChart;
int[] colors = { #ff4444, #33ff99, #5588ff, #d3bd17 };
String[] gyroscopeSeries = { "X", "Y", "Z" };
String[] pyrSeries = { "Pitch", "Roll", "Yaw" };
String[] PWDSeries = { "w1", "w2", "w3", "w4" };

// Data for gyroscope X, Y, Z
float[][] gyroscopeValues = new float[3][maxSamples];

// Data for gyroscope Pitch, Roll, Yaw
float[][] pyrValues = new float[3][maxSamples];

// Data for motor's speeds
float[][] PWDValues = new float[4][maxSamples];

// Rotation Cube
PGraphics pgRotationCube;
PGraphics pgPWDBars;

void setup() {
  //size(755, 550, P2D);
  fullScreen(P2D);

  // Serial
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.bufferUntil(10);
  stroke(255);
}

void draw() {
<<<<<<< HEAD


  //if (hasData) return;
    background(0);

    drawChart("Velocidad Angular [deg/sec]", gyroscopeSeries, gyroscopeValues, 10, 10, width / 2 - 20, height / 3  - 20, true, true, -2000, 2000, 500);
    drawChart("Angulos [deg]", pyrSeries, pyrValues, 10, height / 3 + 10, width / 2 - 20, height / 3  - 20, true, true, -180, 180, 60);
    drawChart("PWD [ms]", PWDSeries, PWDValues, 10, 2 * height / 3 + 10, width / 2 - 20, height / 3  - 20, true, true, 1500, 2000, 100);
    drawBarChart("PWD [ms]", PWDSeries, PWDValues, width / 2 + 10, 2 * height / 3 + 10, height / 3  - 20, height / 3  - 20, true, true, 1500, 2000, 100);

    int side = max(width / 4 - 20, height / 2 - 20);

    drawRotationCube(width / 2 + 10, 10, side, side);
=======
  if (!hasData) return;
  background(0);

  drawChart("Velocidad Angular [deg/sec]", gyroscopeSeries, gyroscopeValues, 10, 10, width / 2 - 20, height / 3  - 20, true, true, -2000, 2000, 500);
  drawChart("Angulos [deg]", pyrSeries, pyrValues, 10, height / 3 + 10, width / 2 - 20, height / 3  - 20, true, true, -180, 180, 60);
  drawChart("PWD [ms]", PWDSeries, PWDValues, 10, 2 * height / 3 + 10, width / 2 - 20, height / 3  - 20, true, true, 1500, 2000, 100);
  drawBarChart("PWD [ms]", PWDSeries, PWDValues, width / 2 + 10, 2 * height / 3 + 10, height / 3  - 20, height / 3  - 20, true, true, 1500, 2000, 100);
  
  drawRotationCube(width / 2 + 10, 10, 2 * height / 3 - 20, 2 * height / 3 - 20);

  println(mouseX, mouseY);
>>>>>>> 29f642fb7d0e49ed2a13f5128cebc1c84c9bcaa2
}