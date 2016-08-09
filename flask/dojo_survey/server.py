from flask import Flask, render_template, request, redirect
app = Flask(__name__)

@app.route('/')
def index():
  return render_template("home_page.html")

@app.route('/survey', methods=['POST'])
def create_user():
   print "Got Post Info"
  
   name = request.form['name'],
   location = request.form['location'],
   language = request.form['language'],
   comments = request.form['comments']
   
   print "stored variables"
   return render_template('result.html', name=name, location=location, language=language, comments=comments)
   # ['/result', name, location, language, comments]

@app.route('/result')
def diplay_info():
	print "Displaying info"
	return render_template("result.html")
app.run(debug=True) 