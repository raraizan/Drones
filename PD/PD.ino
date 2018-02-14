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

void setup() 
{
  Serial.begin(115200);

  // Initialize L3G4200D
  // Set scale 2000 dps and 400HZ Output data rate (cut-off 50)
  while (!gyroscope.begin(L3G4200D_SCALE_2000DPS, L3G4200D_DATARATE_400HZ_50))
  {
    // Waiting for initialization

    if (Blink)
    {
      digitalWrite(LED_BUILTIN, HIGH);
    } else
    {
      digitalWrite(LED_BUILTIN, LOW);
    }

    Blink = !Blink;

    delay(500);
  }

  digitalWrite(LED_BUILTIN, HIGH);

  // Calibrate gyroscope. The calibration must be at rest.
  // If you don't want calibrate, comment this line.
  gyroscope.calibrate(100);

  digitalWrite(LED_BUILTIN, LOW);
}

void loop()
{
  timer = millis();
  control();
  
  // Read normalized values
  Vector norm = gyroscope.readNormalize();

  // Calculate Pitch, Roll and Yaw
  pitch = pitch + norm.YAxis * timeStep;
  roll = roll + norm.XAxis * timeStep;
  yaw = yaw + norm.ZAxis * timeStep;

  // Output raw
  Serial.print(norm.XAxis);
  Serial.print(":");
  Serial.print(norm.YAxis);
  Serial.print(":");
  Serial.print(norm.ZAxis);
  Serial.print(":");
  Serial.print(pitch);
  Serial.print(":");
  Serial.print(roll);
  Serial.print(":");
  Serial.println(yaw);

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
  delay((timeStep*1000) - (millis() - timer));
}
