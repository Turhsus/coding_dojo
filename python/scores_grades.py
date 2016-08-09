print "Scores and Grades"

def get_grade(score):
	if (score <= 69):
		return " Your grade is D"
	elif (score <= 79):
		return " Your grade is C"
	elif (score <= 89):
		return " Your grade is B"
	else:
		return " Your grade is A"

for item in range (0, 10):
	print "Test Score?"
	score = input()
	print "Score: " + str(score) + ";" + get_grade(score)

print "End of the program. Bye!"
