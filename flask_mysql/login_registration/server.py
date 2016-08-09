from flask import Flask, request, redirect, render_template, session, flash
from mysqlconnection import MySQLConnector
from flask.ext.bcrypt import Bcrypt
import re

EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')
app = Flask(__name__)
app.secret_key = "IAmASECRET"
bcrypt = Bcrypt(app)
mysql = MySQLConnector(app,'login_register')

@app.route('/')
def index():
    if 'user' in session:
        return redirect('/success')
    else:
        return render_template('login.html')

@app.route('/success')
def success():
    query = "SELECT * FROM users"
    users = mysql.query_db(query)
    if 'user' in session:
        return render_template('success.html')
    else:
        flash("Not logged in!")
        return redirect('/')

@app.route('/register')
def register():
    return render_template('register.html')

@app.route('/register_user', methods=['POST'])
def add_user():
    first = request.form['first_name']
    last = request.form['last_name']
    email = request.form['email']
    password = request.form['Password']
    confirmed = request.form['confirm']
    valid = True
    if (len(first) < 2):
        flash("First name too short!")
        valid = False;
    if not first.isalpha():
        flash("First name has non letter characters!")
        valid = False;
    if (len(last) < 2):
        flash("Last name too short!")
        valid = False;
    if not last.isalpha():
        flash("Last name has non letter characters!")
        valid = False;
    if email < 1:
        flash("No email!")
        valid = False;
    if not EMAIL_REGEX.match(email):
        flash("Invalid email!")
        valid = False;
    if password < 8:
        flash("Password too short!")
        valid = False;
    if password != confirmed:
        flash("Passwords do not match!")
        valid = False;
    if valid:
        pw_hash = bcrypt.generate_password_hash(password)
        query = "INSERT INTO users (email, first_name, last_name, pw_hash, created_at, updated_at) " \
                "VALUES (:email, :first_name, :last_name, :pw_hash, NOW(), NOW())"
        data = {
            'email': email,
            'first_name': first,
            'last_name': last,
            'pw_hash': pw_hash
        }
        mysql.query_db(query, data)
        session['user'] = first
        return redirect('/success')
    else:
        return redirect('/')

@app.route('/login', methods=['POST'])
def login():
    email = request.form['email']
    test_password = request.form['Password']
    try:
        query = "SELECT first_name, pw_hash FROM users WHERE email = :email"
        data = {
            'email': email
        }
        user = mysql.query_db(query, data)
        pw_hash = user[0]['pw_hash']
        if bcrypt.check_password_hash(pw_hash, test_password):
            session['user'] = user[0]['first_name']
            return redirect('/wall`')
        else:
            flash("Email and password do not match!")
            return redirect('/')
    except IndexError:
        flash("Email not in database!")
        return redirect('/')

@app.route('/log_out', methods=['POST'])
def log_out():
    session.pop('user')
    return redirect('/')

app.run(debug=True)