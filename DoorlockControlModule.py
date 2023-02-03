import time
import atexit
from datetime import datetime

import RPi.GPIO as GPIO

import firebase_admin
from firebase_admin import credentials, firestore, db

import base64
from Crypto.Cipher import AES

def exit_handler():
    print("Exiting program")

    logFile.close()

atexit.register(exit_handler)

def divide_string(string):
    return string.split("/")

def decrypt_aes_128(key_b64, iv_b64, encrypted_text):
    # Decode the key and IV from base64
    key = base64.b64decode(key_b64)
    iv = base64.b64decode(iv_b64)

    # Initialize the cipher with the decoded key and IV
    cipher = AES.new(key, AES.MODE_CBC, iv)

    # Decode the encrypted text from base64 and decrypt it
    encrypted_bytes = base64.b64decode(encrypted_text)
    decrypted_text = cipher.decrypt(encrypted_bytes)

    # Remove the padding from the decrypted text
    padding = decrypted_text[-1]
    decrypted_text = decrypted_text[:-padding]
    
    return decrypted_text.decode()

def divide_string(string):
    # Divide String by '/' and return divided String Array
    return string.split("/")

### Init Setting ###
GPIO_PIN_NUMS = [5, 6, 22, 27]          # Doorlock Relay 신호 Pin 넘버 (Std >> 5 // Dlx >> 6 // Exc >> 22 // Sup >> 27)
DELAY_TIME = 0.1                        # Doorlock OPEN 신호 주기 (SEC, type 'float')
AUTH_FILENAME = '/home/pi/Projects/flutterfirebaselogin-fe24a-firebase-adminsdk-9grre-6c770a417f.json'
                                        # Firebase Auth Filename (type 'str')
LOG_FILENAME = '/home/pi/Projects/LogFile/logFile.txt'
                                        # Log File route/name.txt (type 'str')
GPIO.setmode(GPIO.BCM)                  # GPIO Pin 넘버 기준 (GPIO.BCM / GPIO.BOARD)

### Firebase Setting ###
cred = credentials.Certificate(AUTH_FILENAME)
firebase_admin.initialize_app(cred)
client = firestore.client()

ORDER_COLLECTION_REF = client.collection(u'order').document(u'raspberrypi')

### Logfile Init ###
logFile = open(LOG_FILENAME, 'a')
logFile.write(f'Device Init... at {str(datetime.now())}\n')

while 1:
    print("### loop ###")
    GPIO.setup(GPIO_PIN_NUMS, GPIO.IN)

    ORDER_SET = ORDER_COLLECTION_REF.get().to_dict()
    order_content = ORDER_SET[u'order']

    if order_content == True:
        order_info = divide_string(decrypt_aes_128(ORDER_SET[u'key'], ORDER_SET[u'ivkey'], ORDER_SET[u'value']))
            # order_info[0] >> Email // order_info[1] >> RoomType // order_info[2] >> Reservation info

        member_info = client.collection(u'member').document(order_info[0]).get().to_dict()

        if member_info[u'reservation'] == True and member_info[u'rooms'] == order_info[1] :

            if member_info[u'rooms'] == 'Standard' :
                channel = 5
            elif member_info[u'rooms'] == 'Deluxe' :
                channel = 6
            elif member_info[u'rooms'] == 'Executive' :
                channel = 22
            elif member_info[u'rooms'] == 'Superior' :
                channel = 27
            
            print('Door lock controlled...')
            print(member_info[u'email'])
            print(member_info[u'rooms'])

            logFile.write(str(datetime.now()))
            logFile.write("\tDoorlock Open by ")
            logFile.write(order_info[0])
            logFile.write("...\n")
				
            GPIO.setup(channel,GPIO.OUT)
            GPIO.output(channel,True)
            time.sleep(0.1)
            GPIO.setup(channel,GPIO.IN)

            channel = 0
            
            ORDER_COLLECTION_REF.set({u'ivkey' : "", u'key' : "", u'order' : False, u'value' : ""})
    time.sleep(1)
