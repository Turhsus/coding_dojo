import random
heads = 0
tails = 0

def toss_coin():
	global heads
	global tails
	coin = round(random.random())
	if (coin == 0):
		heads = heads + 1
	else:
		tails = tails + 1

for tossNumber in range (1, 5001):
	print "Attempt #", tossNumber, "Throwing a coin...", toss_coin(), "Got", heads, "head(s) so far and", tails, "tail(s) so far"

print "Ending the program, thank you!"