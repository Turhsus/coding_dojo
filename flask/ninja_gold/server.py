from flask import Flask, request, redirect, session, render_template
import random
import datetime

app = Flask(__name__)
app.secret_key = "secret"

@app.route('/')
def earnmoney():
    # session['gold'] = 0
    # session['tracker'] = []
    try:
        session['gold'] = session['gold']
        session['tracker'] = session['tracker']
    except KeyError:
        session['gold'] = 0
        session['tracker'] = ['nothing']

    return render_template("money_home.html", list=session['tracker'])

@app.route("/process_money", methods=['POST'])
def sendMoney():
    if (request.form['gold_type'] == 'farm'):
        earned = int(random.randrange(10, 20))
        session['gold'] += earned
        logStr = "Earned " + str(earned) + " from the farm! " + str(datetime.datetime.now())
        session['tracker'].insert(0, logStr)
    elif (request.form['gold_type']  == 'cave'):
        earned = int(random.randrange(5, 10))
        session['gold'] += earned
        logStr = "Earned " + str(earned) + " from the cave! " + str(datetime.datetime.now())
        session['tracker'].insert(0, logStr)
    elif (request.form['gold_type'] == 'house'):
        earned = int(random.randrange(2, 5))
        session['gold'] += earned
        logStr = "Earned " + str(earned) + " from the house! " + str(datetime.datetime.now())
        session['tracker'].insert(0, logStr)
    elif (request.form['gold_type'] == 'casino'):
        earned = int(random.randrange(-50, 50))
        session['gold'] += earned
        if earned < 0:
            logStr = "Earned " + str(earned) + " from the casino! Ouch. " + str(datetime.datetime.now())
        elif earned >= 0:
            logStr = "Earned " + str(earned) + " from the casino! " + str(datetime.datetime.now())
        session['tracker'].insert(0,logStr)
    return redirect('/')


app.run(debug=True)