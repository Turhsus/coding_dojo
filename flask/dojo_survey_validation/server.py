from flask import Flask, render_template, request, redirect, session, flash

app = Flask(__name__)

app.secret_key = "lol"


@app.route('/')
def index():
    return render_template("home_page.html")


@app.route('/survey', methods=['POST'])
def create_user():
    print "Got Post Info"

    if len(request.form['name']) < 1:
        flash("Name is empty!")
        return redirect('/')
    else:
        session['name'] = request.form['name']
    if len(request.form['comments']) < 1 or len(request.form['comments']) > 120:
        flash("Comments are too long or empty!")
        return redirect('/')
    else:
        session['comments'] = request.form['comments']

    session['location'] = request.form['location']
    session['language'] = request.form['language']
    print "stored variables"
    return redirect('/result')


@app.route('/result')
def diplay_info():
    print "Displaying info"
    return render_template("result.html")


app.run(debug=True)
