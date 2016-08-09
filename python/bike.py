class Bike(object):
	def __init__(self, price, max_speed, miles = 0):
		self.price = price
		self.max_speed = max_speed
		self.miles = miles
	def displayInfo(self):
		print "Price:", self.price, "Dollars; Max Speed:", self.max_speed, "MPH; Miles:", self.miles
		return self
	def ride(self):
		print "Riding"
		self.miles += 10
		return self
	def reverse(self):
		if (self.miles > 0):
			print "Reversing"
			self.miles -= 5
			return self
		else:
			print "Cannot Reverse!"
			return self

motorbike = Bike(1000, 100)
bicycle = Bike(200, 25)
tricycle = Bike (500, 20)

motorbike.ride().ride().ride().reverse().displayInfo()

bicycle.ride().ride().reverse().reverse().displayInfo()

tricycle.reverse().reverse().reverse().displayInfo()

