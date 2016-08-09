from flask import Flask, request, redirect, render_template, session, flash
from mysqlconnection import MySQLConnector
from flask_bcrypt import Bcrypt
import re

EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')
app = Flask(__name__)
app.secret_key = "IAmASECRET"
bcrypt = Bcrypt(app)
mysql = MySQLConnector(app,'wallDB')

@app.route('/')
def login_register():
    if 'user' in session:
        return redirect('/wall')
    else:
        return render_template('login.html')

@app.route('/wall')
def the_wall():
    query = "SELECT messages.id AS mid, messages.created_at AS mcat, first_name, last_name, message FROM messages " \
            "JOIN users ON users.id = messages.user_id"
    messages = mysql.query_db(query)
    query = "SELECT comments, comments.created_at AS ccat, message_id, first_name, last_name FROM comments " \
            "JOIN users ON users.id = comments.user_id"
    comments = mysql.query_db(query)
    print session['user_id']
    if 'user' in session:
        return render_template('wall.html', all_messages = messages, all_comments = comments)
    else:
        flash("Not logged in!")
        return redirect('/')

@app.route('/login', methods=['POST'])
def enter_site():
    if (request.form['enter'] == 'login'):
        email = request.form['email']
        test_password = request.form['Password']
        try:
            query = "SELECT * FROM users WHERE email = :email"
            data = {
                'email': email
            }
            user = mysql.query_db(query, data)
            pw_hash = user[0]['password']
            print pw_hash
            if bcrypt.check_password_hash(pw_hash, test_password):
                session['user'] = user[0]['first_name']
                session['user_id'] = user[0]['id']
                return redirect('/wall')
            else:
                flash("Email and password do not match!")
                return redirect('/')
        except IndexError:
            flash("Email not in database!")
            return redirect('/')
    elif (request.form['enter'] == 'register'):
        print "/login register"
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
            query = "INSERT INTO users (email, first_name, last_name, password, created_at, updated_at) " \
                    "VALUES (:email, :first_name, :last_name, :pw_hash, NOW(), NOW())"
            data = {
                'email': email,
                'first_name': first,
                'last_name': last,
                'pw_hash': pw_hash
            }
            mysql.query_db(query, data)
            query = "SELECT * FROM users WHERE email = :email"
            data = {
                'email': email
            }
            user = mysql.query_db(query, data)
            session['user'] = first
            session['user_id'] = user[0]['id']
            return redirect('/wall')
        else:
            return redirect('/')

@app.route('/log_out', methods=['POST'])
def log_out():
    session.clear()
    return redirect('/')

@app.route('/message', methods=['POST'])
def message():
    query = "INSERT INTO messages (message, created_at, updated_at, user_id) " \
            "VALUES (:message, NOW(), NOW(), :user_id)"
    data = {
        'message': request.form['message'],
        'user_id': session['user_id']
    }
    mysql.query_db(query, data)
    return redirect('/wall')

@app.route('/comment/<message_id>', methods=['POST'])
def comment(message_id):
    print "posting comment"
    query = "INSERT INTO comments (comments, created_at, updated_at, message_id, user_id) " \
            "VALUES (:comment, NOW(), NOW(), :message_id, :user_id)"
    data = {
        'comment': request.form['comment'],
        'message_id': message_id,
        'user_id': session['user_id']
    }
    mysql.query_db(query, data)
    return redirect('wall')


app.run(debug=True)
