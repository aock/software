#include <iostream>
#include <embree3/rtcore.h>

#include <stdio.h>
#include <math.h>

void errorFunction(void* userPtr, enum RTCError error, const char* str)
{
  printf("error %d: %s\n", error, str);
}

RTCDevice initializeDevice()
{
  RTCDevice device = rtcNewDevice(NULL);

  if (!device)
    printf("error %d: cannot create device\n", rtcGetDeviceError(NULL));

  rtcSetDeviceErrorFunction(device, errorFunction, NULL);
  return device;
}


int main(int argc, char** argv)
{
    RTCDevice device = initializeDevice();

    std::cout << rtcGetDeviceProperty(device, RTC_DEVICE_PROPERTY_VERSION_MAJOR) 
              << "." << rtcGetDeviceProperty(device, RTC_DEVICE_PROPERTY_VERSION_MINOR)
              << "." << rtcGetDeviceProperty(device, RTC_DEVICE_PROPERTY_VERSION_PATCH) << std::endl;

    return 0;
}