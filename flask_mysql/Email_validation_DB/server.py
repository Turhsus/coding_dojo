from flask import Flask, request, redirect, render_template, session, flash
from mysqlconnection import MySQLConnector
import re

EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')
app = Flask(__name__)
app.secret_key = "IAmASECRET"
mysql = MySQLConnector(app,'email')

@app.route('/')
def index():
    return render_template('home_emailDB.html')

@app.route('/success')
def success():
    query = "SELECT id, email, CREATED_AT, UPDATED_AT FROM email"
    emails = mysql.query_db(query)
    print emails
    return render_template('success.html', all_email = emails)

@app.route('/survey', methods=['POST'])
def create():
    if len(request.form['email']) < 1:
        flash("Email is blank!")
        return redirect('/')
    elif not EMAIL_REGEX.match(request.form['email']):
        flash("Invalid Email Address!")
        return redirect('/')
    else:
        query = "INSERT INTO email (email, CREATED_AT, UPDATED_AT)" \
                "VALUES (:email, NOW(), NOW())"
        data = {'email': request.form['email']}
        mysql.query_db(query, data)
        flash("The email address you entered " + request.form['email'] + " is valid! Thank you!")
        return redirect('/success')

@app.route('/delete/<delete_id>', methods=['POST'])
def delete(delete_id):
    print "hi!"
    print delete_id
    query = "DELETE FROM email WHERE id = :id"
    data = {'id': delete_id}
    mysql.query_db(query, data)
    flash('Deleted!')
    return redirect('/success')

app.run(debug=True)