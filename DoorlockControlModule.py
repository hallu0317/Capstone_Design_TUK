#-*-conding:utf-8 -*-
import time
import os, ntpath
import json
import subprocess
import atexit

from datetime import datetime

#import RPi.GPIO as GPIO
from flask import Flask
from flask import request

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import db

### Config Info Setup ###
CONTROL_PIN = 17        # Doorlock OPEN Relay 신호 핀 넘버
ROOM_TYPE = 'Standard'  # Doorlock Roomtype (type 'str')
DELAY_TIME = 0.1        # Doorlock OPEN 신호 주기 (SEC, type 'float')
AUTH_FILENAME = 'flutterfirebaselogin-fe24a-firebase-adminsdk-9grre-6c770a417f.json'
                        # Firebase Auth Filename (type 'str')
LOG_FILENAME = './LogFile/logFile.txt'
                        # Log File route/name.txt (type 'str')
RECEIVING_IP = ''
                        # IP Address of RaspberryPI (type 'str')

### Global Init ###

logFile = open(LOG_FILENAME, 'a')
logFile.write(f'Device Init... at {str(datetime.now())}\n')
logFile.close()

cred = credentials.Certificate(AUTH_FILENAME)
firebase_admin.initialize_app(cred)
client = firestore.client()

ORDER_COLLECTION_REF = client.collection(u'order').document(u'raspberrypi')

#GPIO.setmode(GPIO.BCM)
Flask_APP = Flask(__name__)


def firebaseInfoLoad(userEmail, roomtype):
    REQUEST_USER_REF=client.collection(u'member').document(userEmail).get().to_dict()

    if REQUEST_USER_REF == None:
        return -1

    if REQUEST_USER_REF[u'reservation'] == True:
        if REQUEST_USER_REF[u'rooms'] == ROOM_TYPE:
            return 0

        else:
            return -3

    else:
        return -2

@Flask_APP.route('/open',methods=['POST'])
def openRequest():
    ### Open Request by User
    requestData = request.get_json()
    userEmail = requestData['email']    # Request User Email
    roomtype = requestData['roomtype']  # Request Roomtype

    if roomtype == ROOM_TYPE:
        requestReturn = firebaseInfoLoad(userEmail, roomtype)

        if requestReturn == 0:
            ### 정상 처리
            print(f"'[{userEmail}] open at {str(datetime.now())}")
            logFile = open(LOG_FILENAME, 'a')
            logFile.write(f'[Control Success] Doorlock Controlled at {str(datetime.now())} by [{userEmail}]\n')
            logFile.close()

            ### Control GPIO to Open Doorlock
#            GPIO.setup(CONTROL_PIN, GPIO.OUT)
#            GPIO.output(CONTROL_PIN, True)
#            time.sleep(DELAY_TIME)
#            GPIO.setup(CONTROL_PIN, GPIO.IN)

            ### Set Order Collection Empty
            ORDER_COLLECTION_REF.set({u'order' : ""})

        elif requestReturn == -1:
            ### Member Collection 내에 Email 부재
            print("Error >> User not found.")
            logFile = open(LOG_FILENAME, 'a')
            logFile.write(f'[Control Fail >> User not found.] at {str(datetime.now())} by [{userEmail}]\n')
            logFile.close()

            ### Set Order Collection Empty
            ORDER_COLLECTION_REF.set({u'order' : ""})

        elif requestReturn == -2:
            ### user의 예약상태가 false 임
            print("Error >> User Reservation Status is FALSE.")
            logFile = open(LOG_FILENAME, 'a')
            logFile.write(f'[Control Fail >> User Reservation Status is FALSE.] at {str(datetime.now())} by [{userEmail}]\n')
            logFile.close()

            ### Set Order Collection Empty
            ORDER_COLLECTION_REF.set({u'order' : ""})

        elif requestReturn == -3:
            ### user의 예약 호실 정보와 요청 호실 정보가 일치하지 않음
            print("Error >> User Reservation Info does not match.")
            logFile = open(LOG_FILENAME, 'a')
            logFile.write(f'[Control Fail >> User Reservation Info does not match.] at {str(datetime.now())} by [{userEmail}]\n')
            logFile.close()

            ### Set Order Collection Empty
            ORDER_COLLECTION_REF.set({u'order' : ""})

    else:
        ### Requested Roomtype과 Device Roomtype이 일치하지 않음.
        print("Error >> Request Roomtype and Device Roomtype does not match")
        logFile = open(LOG_FILENAME, 'a')
        logFile.write(f'[Control Fail >> Request Roomtype and Device Roomtype does not match] at {str(datetime.now())} by [{userEmail}]\n')
        logFile.close()

        ### Set Order Collection Empty
        ORDER_COLLECTION_REF.set({u'order' : ""})

def handle_exit():
    logFile = open(LOG_FILENAME, 'a')
    logFile.write(f'[Exit] at {str(datetime.now())}\n\n')
    logFile.close()

if __name__ == "__main__":
    atexit.register(handle_exit)
#    GPIO.setup(17,GPIO.IN)

    Flask_APP.run(host = RECEIVING_IP)