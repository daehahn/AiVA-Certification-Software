import serial
import time

ser = serial.Serial('/dev/ttyMSM1', 9600, timeout=1)
ser.close()
ser.open()

print("testing start..")
cnt = 0
try:
	while 1:
	    cnt = cnt + 1
	    if cnt > 9:
		cnt = 0
            ser.write(str(cnt));
            print(">>>>>> send: " + str(cnt))
            time.sleep(1)
	    response = ser.read()

            if len(response) > 0:
	        print("<<<<<< receive: " + response)
except KeyboardInterrupt:
	ser.close()
