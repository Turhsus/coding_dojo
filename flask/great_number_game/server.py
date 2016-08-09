from flask import Flask, request, redirect, session, render_template
import random

app = Flask(__name__)
app.secret_key = "secret"


@app.route('/')
def game():
    try:
        print "hi!"
        if session['guess'] > session['answer']:
            session['correctness'] = "Too High!"
        elif (session['guess'] < session['answer']):
            session['correctness'] = "Too Low!"
        elif (session['guess'] == session['answer']):
            session['correctness'] = "Correct!"
        return render_template('home.html')
    except KeyError:
        print "KeyError!"
        session['correctness'] = ""
        session['answer'] = int(round(random.randrange(0, 101)))
        return render_template('home.html')


@app.route('/guess', methods=['POST'])
def guess():
    if (request.form['form_type'] == "guesser"):
        print "Submitted!"
        session['guess'] = int(request.form['my_guess'])
        print "guess_submitted:",session['guess']
        print "answer_submitted:",session['answer']
        return redirect('/')
    elif (request.form['form_type'] == "resetting"):
        session.pop('answer', None)
        session.pop('correctness', None)
        session.pop('guess', None)
        return redirect('/')


app.run(debug=True)
