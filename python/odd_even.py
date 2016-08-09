def print_even(num):
	print "Number is", num, ". This is an even number."

def print_odd(num):
	print "Number is", num, ". This is an odd number."

for num in range(1, 2001):
	if (num % 2 == 0):
		print_even(num)
	else:
		print_odd(num)