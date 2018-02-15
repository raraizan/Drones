void serialEvent (Serial myPort)
{
  String inString = myPort.readStringUntil(10);

  if (inString != null)
  {
    inString = trim(inString);
    String[] list = split(inString, ':');
    String testString = trim(list[0]);

    if (list.length != 10) return;

    for (int j = 0; j < gyroscopeValues.length; j++)
    {
      gyroscopeValues[j][actualSample] = (float(list[j]));
    }

    for (int j = 0; j < pyrValues.length; j++)
    {
      pyrValues[j][actualSample] = (float(list[j+3]));
    }

    for (int j = 0; j < PWDValues.length; j++)
    {
      PWDValues[j][actualSample] = (float(list[j+6]));
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