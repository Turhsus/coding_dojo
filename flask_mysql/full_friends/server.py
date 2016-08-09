from flask import Flask, request, redirect, render_template, session, flash
from mysqlconnection import MySQLConnector
import re

EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$')
app = Flask(__name__)
app.secret_key = "IAmASECRET"
mysql = MySQLConnector(app,'friendsdb')

@app.route('/')
def index():
    query = "SELECT * FROM friends"
    friends = mysql.query_db(query)
    return render_template('index.html', all_friends=friends)

@app.route('/friends/<id>/edit')
def edit(id):
    print "get edit route"
    query = "SELECT * FROM friends " \
            "WHERE id = :id"
    data = {
        'id': id
    }
    edit_friend = mysql.query_db(query, data)
    return render_template('edit_friends.html', friend = edit_friend)

@app.route('/friends', methods=['POST'])
def create():
    query = "INSERT INTO friends (first_name, last_name, occupation, created_at, updated_at)" \
            "VALUES (:first_name, :last_name, :occupation, NOW(), NOW())"
    data = {
        'first_name': request.form['first_name'],
        'last_name': request.form['last_name'],
        'occupation': request.form['occupation']
    }
    mysql.query_db(query, data)
    return redirect('/')

@app.route('/friends/<id>', methods=['POST'])
def update(id):
    print "updating"
    print id
    query = "UPDATE friends " \
            "SET first_name = :first_name, last_name = :last_name, occupation = :occupation, updated_at = NOW() " \
            "WHERE id = :id"
    data = {
        'first_name': request.form['first_name'],
        'last_name': request.form['last_name'],
        'occupation': request.form['occupation'],
        'id': id
    }
    mysql.query_db(query, data)
    return redirect('/')

@app.route('/friends/<id>/delete', methods=['POST'])
def destroy(id):
    print "hello"
    query = "DELETE FROM friends WHERE id = :id"
    data = {'id': id}
    mysql.query_db(query, data)
    return redirect('/')

app.run(debug=True)