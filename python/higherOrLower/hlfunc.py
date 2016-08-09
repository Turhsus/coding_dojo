try_num = 0
hi_lo = False

import time

def higher_or_lower():
	global guess
	global hi_lo
	global remainder
	remainder = round(remainder / 2)
	if (hi_lo):
		guess = remainder + guess
	else:
		guess = guess - remainder


		
#The Variable hi_lo is true when the correct answer is higher, and false if the correct answer is lower
#default for hi_lo is false so as to indicate the first guess amount
def turn():
	global try_num
	global guess
	global hi_lo
	global found_answer
	try_num += 1
	if (try_num == 7):
		higher_or_lower()
		print "Try Number", try_num
		time.sleep(.5)
		print guess, "is your answer!"
		found_answer = True
	else:
		valid_input = True
		higher_or_lower()
		print "Try Number", try_num
		time.sleep(.5)
		print "I guess", guess, "is your number. Was I correct? Y/N"
		yes_no = raw_input()
		while (valid_input):
			if (yes_no == 'Y'):
				print "Yay!"
				found_answer = True
				valid_input = False
			elif (yes_no == 'N'):
				print "Aww man, is it higher or lower? H/L"
				hl = raw_input()
				good_input = True
				while good_input:
					if (hl == 'H'):
						hi_lo = True
						good_input = False
						print "hi"
						if (guess > 98.0):
							print "Try Number", try_num
							guess = 0
							print guess, "is your answer!"
							found_answer = True
							valid_input = False
					elif (hl == 'L'):
						hi_lo = False
						good_input = False
						if (guess < 2.0):
							print "Try Number", try_num
							guess = 0
							print guess, "is your answer!"
							found_answer = True
							valid_input = False
					else:
						print "I'm sorry that was invalid input care to try again?"
				valid_input = False

				time.sleep(.5)
			else:
				print "I'm sorry that was invalid input, care to try again?"
				yes_no = raw_input()
				time.sleep(.5)
