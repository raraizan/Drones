#include <Wire.h>
#include <L3G4200D.h>

L3G4200D gyroscope;

// Timers
unsigned long timer = 0;
float timeStep = 0.01;

// Pitch, Roll and Yaw values
float pitch = 0;
float roll = 0;
float yaw = 0;

boolean Blink = false;

void setup() {
  Serial.begin(115200);

  // Initialize L3G4200D
  // Set scale 2000 dps and 400HZ Output data rate (cut-off 50)

  while (!gyroscope.begin(L3G4200D_SCALE_2000DPS, L3G4200D_DATARATE_400HZ_50)) {
    // Waiting for initialization

    if (Blink) {
      digitalWrite(LED_BUILTIN, HIGH);
    } else {
      digitalWrite(LED_BUILTIN, LOW);
    }

    Blink = !Blink;

    delay(255);
  }

  digitalWrite(LED_BUILTIN, HIGH);

  // Calibrate gyroscope. The calibration must be at rest.
  // If you don't want calibrate, comment this line.
  gyroscope.calibrate(100);
  gyroscope.setThreshold(5);
  digitalWrite(LED_BUILTIN, HIGH);
}

void loop() {
  timer = millis();

  // Read normalized values
  Vector velocidadAng = gyroscope.readNormalize();

  // Calculate Pitch, Roll and Yaw
  pitch = pitch + velocidadAng.YAxis * timeStep;
  roll = roll + velocidadAng.XAxis * timeStep;
  yaw = yaw + velocidadAng.ZAxis * timeStep;

  Vector orientacionAng = {pitch, roll, yaw};

  // Output raw
  Serial.print(velocidadAng.XAxis);
  Serial.print(":");
  Serial.print(velocidadAng.YAxis);
  Serial.print(":");
  Serial.print(velocidadAng.ZAxis);
  Serial.print(":");
  Serial.print(orientacionAng.XAxis);
  Serial.print(":");
  Serial.print(orientacionAng.YAxis);
  Serial.print(":");
  Serial.print(orientacionAng.ZAxis);
  Serial.print(":");
  Serial.print(1750);
  Serial.print(":");
  Serial.print(1500);
  Serial.print(":");
  Serial.print(1800);
  Serial.print(":");
  Serial.println(1600);

  // Output indicator
  if (Blink)
  {
    digitalWrite(LED_BUILTIN, HIGH);
  } else
  {
    digitalWrite(LED_BUILTIN, LOW);
  }

  Blink = !Blink;

  // Wait to full timeStep period
  delay((timeStep * 1000) - (millis() - timer));
}
