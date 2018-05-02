import serial
import time

ser = serial.Serial("COM4", 9600)
ser.close()
ser.open()

print("testing start")

try:
	while 1:
		response = ser.read()
		print(response)
		time.sleep(1)
		ser.write(response)
except KeyboardInterrupt:
	ser.close()