# Al infinito y mas alla en un Drone
##### Estatus actual:
 * No funcional (27/01/18)
 * El giroscopio funciona (28/01/18)
 * la visualizacion y salida de datos funciona (implementada en processing)


### Objetivos

* Hacer funcionar el giroscopio. [Done]
* Metodo de visualizacion. [Done]
* Implementar modelo de control (PID). []
    * Investigar modelos de control. []
* Hacer funcionar motores y ESC's. []
* Rediseñar chasis y fabricar chasis. []
* Diseñar PCB y fabricarla. []
* Hacer pruebas de vuelo y calibrar PID. []

### Hardware utilizado

* [Arduino micro](https://store.arduino.cc/usa/arduino-micro) ([pinout](Images/arduino_micro_pinout.png))
* [Giroscopio l3g4200d gy-50](https://www.gearbest.com/development-boards/pp_58062.html)
Giroscopio de 3 ejes. Se utiliza la libreria [L3G4200D.h](https://github.com/jarzebski/Arduino-L3G4200D)
* [Esc]()
* [motores]()
* [Radio]()

### Bitacora

* [27/01/18] Control de sensores (Giroscopio)

    * Busqueda de informacion e implementacion de la libreria [L3G4200D.h](https://github.com/jarzebski/Arduino-L3G4200D).
    * se utiliza comunicacion digital por medio de I2C ([diagrama](Images/arduino_gyro.png))
    * Se modificaron ejemplos incluidos en la libreria para la lectura y visualizacion de los datos de giroscopio.
    * Falta mejorar la calibracion (mucho ruido y un drift pequeño en la orientacion).
    
* [01/02/18] Implementar modelo de control, se trabaja en un sistema PD.
    
    * Se utiliza copia de Gyro.ino para implementar PD y trabajar con sketches de processing.
    
* [14/02/18]
    

### Indicaciones

* Para instalar la libreria L3G4200D.h, arrastrar la carpeta *libraries* a la carpeta de librerias de arduino.
* *Visualizacion_drone_data* y *Visualizacion_drone_lite* funcionan solo con el sketch *Gyro*