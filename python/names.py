#PART 1

students = [
	{'first_name' : 'Michael', 'last_name' : 'Jordan'},
	{'first_name' : 'John', 'last_name' : 'Rosales'},
	{'first_name' : 'Mark', 'last_name' : 'Guillen'},
	{'first_name' : 'KB', 'last_name' : 'Tonel'},
]

for persons in students:
	print persons['first_name'], persons['last_name']

#PART 2

users = {
	'Students' : [
		{'first_name' : 'Michael', 'last_name' : 'Jordan'},
		{'first_name' : 'John', 'last_name' : 'Rosales'},
		{'first_name' : 'Mark', 'last_name' : 'Guillen'},
		{'first_name' : 'KB', 'last_name' : 'Tonel'},
	],
	'Instructors' :[
		{'first_name' : 'Michael', 'last_name' : 'Choi'},
		{'first_name' : 'Martin', 'last_name' : 'Puryear'},
	]
}

global count
count = 0

print 'Students'

for student in users['Students']:
	count += 1
	fullname = student['first_name'] + " " + student['last_name']
	print count, "-", fullname, "-", (len(fullname) - 1)

count = 0
print "Instructors"

for teacher in users['Instructors']:
	count += 1
	fullname = teacher['first_name'] + " " + teacher['last_name']
	print count, "-", fullname, "-", (len(fullname) - 1)