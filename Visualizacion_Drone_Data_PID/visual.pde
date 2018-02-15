void drawRotationCube(int x, int y, int w, int h) {
  pgRotationCube = createGraphics(w, h, P3D);

  pgRotationCube.beginDraw();
  pgRotationCube.lights();
  pgRotationCube.ortho();
  pgRotationCube.background(0);


  pgRotationCube.pushMatrix();
  pgRotationCube.translate(pgRotationCube.width / 2, pgRotationCube.width / 2, -pgRotationCube.width + 30);

  // Estas rotaciones estan mal
  pgRotationCube.rotateX(radians(pyrValues[0][actualSample-1]));
  pgRotationCube.rotateZ(radians(pyrValues[1][actualSample-1])); 
  pgRotationCube.rotateY(radians(pyrValues[2][actualSample-1]));

  pgRotationCube.box(100);
  pgRotationCube.popMatrix();


  pgRotationCube.noFill();
  pgRotationCube.stroke(100);
  pgRotationCube.rect(0, 0, w - 1, h - 1);

  pgRotationCube.endDraw();
  image(pgRotationCube, x, y);
}

void drawBarChart(String title, String[] series, float[][] chart, int x, int y, int w, int h, boolean symmetric, boolean fixed, int fixedMin, int fixedMax, int hlines) {
  int actualColor = 0;

  int maxA = 0;
  int maxB = 0;
  int maxAB = 0;

  int min = 0;
  int max = 0;
  int step = 0;
  int divide = 0;
  float sideStep = (w - 40.) / chart.length;
  float side = 0.8 * sideStep;

  if (fixed) {
    min = fixedMin;
    max = fixedMax;
    step = hlines;
  } else {
    if (hlines > 2) {
      divide = (hlines - 2);
    } else {
      divide = 1;
    }

    if (symmetric) {
      maxA = (int)abs(getMin(chart));
      maxB = (int)abs(getMax(chart));
      maxAB = max(maxA, maxB);
      step = (maxAB * 2) / divide;
      min = -maxAB-step;
      max = maxAB+step;
    } else {
      min = (int)(getMin(chart));
      max = (int)(getMax(chart));

      if ((max >= 0) && (min <= 0)) step = (abs(min) + abs(max)) / divide; 
      if ((max < 0) && (min < 0)) step = abs(min - max) / divide; 
      if ((max > 0) && (min > 0)) step = (max - min) / divide; 

      if (divide > 1) {
        min -= step;
        max += step;
      }
    }
  }

  pgChart = createGraphics(w, h);

  pgChart.beginDraw();

  // Draw chart area and title
  pgChart.background(0);
  pgChart.strokeWeight(1);
  pgChart.noFill();
  pgChart.stroke(50);
  pgChart.rect(0, 0, w - 1, h -1);
  pgChart.textAlign(CENTER, TOP);
  pgChart.text(title, (w / 2), 5);

  // Draw chart description
  actualColor = 0;

  for (int j = 0; j < chart.length; j++) {
    pgChart.fill(colors[actualColor]);
    pgChart.textAlign(CENTER, CENTER);
    pgChart.text(series[j], 20 + (.5 + j) * sideStep, h - 15);

    actualColor++;
    if (actualColor >= colors.length) actualColor = 0;
  }


  // Draw H-Lines 
  pgChart.stroke(100);

  for (float t = min; t <= max; t = t + step) {
    float line = map(t, min, max, 30, h - 30);
    pgChart.line(20, h - line, w - 20, h - line);
    pgChart.fill(200, 200, 200);
    pgChart.textSize(12);
    pgChart.textAlign(RIGHT, CENTER);
    //pgChart.text(int(t), 35, h - line);
  }

  // Draw data bars
  pgChart.noStroke();

  for (int j = 0; j < chart.length; j++) {
    pgChart.fill(colors[j]);
    float d = chart[j][actualSample - 1];

    if (d < min) d = min;
    if (d > max) d = max;
    
    float H = map(d, min, max, 0, h - 60);

    pgChart.rect((j + 0.1) * sideStep + 20, h - 30 , side, -H);
  }


  pgChart.endDraw();

  image(pgChart, x, y);
}