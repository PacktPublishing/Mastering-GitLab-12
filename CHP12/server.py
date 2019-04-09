from flask import Flask, request
import json

app = Flask(__name__)

def runsomething():
    print "This is triggered"

@app.route('/',methods=['POST'])
def trigger():
   data = json.loads(request.data)
   print "New commit by: {}".format(data['commits'][0]['author']['name'])
   print "New commit by: {}".format(data['commits'][0]['author']['email'])
   print "New commit by: {}".format(data['commits'][0]['message'])
   
   runsomething()
   return "OK"

if __name__ == '__main__':
   app.run()