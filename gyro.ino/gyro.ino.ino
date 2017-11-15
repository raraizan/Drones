//Arduino 1.0+ only

#include <Wire.h>

#define CTRL_REG1 0x20
#define CTRL_REG2 0x21
#define CTRL_REG3 0x22
#define CTRL_REG4 0x23
#define CTRL_REG5 0x24

int L3G4200D_Address = 105; //I2C address of the L3G4200D

int dRoll;
int Roll = 0;
int dt, dtf = 0, dti = 0;
int prom = 0;
int gain = pow(2, 3);
void setup() {

  Wire.begin();
  Serial.begin(9600);

  Serial.println("starting up L3G4200D");
  setupL3G4200D(2000); // Configure L3G4200  - 250, 500 or 2000 deg/sec

  for (int i = 0; i <= 1000; i++) {
    prom += getGyroX();
    delay(1);
  }
  prom = prom / 1000;
  Serial.println(prom);
  delay(100); //wait for the sensor to be ready
}

void loop() {
  int pdRoll = dRoll;
  dRoll = getGyroX() - prom;

  dt = millis() - dti;

  if (abs(dRoll) > 10) {
    Roll += (pdRoll + 0.5 * (dRoll - pdRoll)) * dt / gain;
  }
  Serial.print(dRoll);
  Serial.print("\t");
  Serial.print(Roll);
  Serial.print("\t");
  Serial.println(dt);

  dti = millis();
  delay(1); // para estabiliad
}


