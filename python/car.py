class Car(object):
	def __init__(self, price, speed, fuel, mileage, tax = 0.12):
		self.tax = tax
		self.price = price
		if(self.price > 10000):
			self.tax = .15
		self.speed = speed
		self.fuel = fuel
		self.mileage = mileage
		self.display_all()
	def display_all(self):
		print "Price:", self.price
		print "Speed:", str(self.speed) + "mph"
		print "Fuel:", self.fuel
		print "Mileage:", str(self.mileage) + "mpg"
		print "Tax:", self.tax

car1 = Car(2000, 35, "Full", 15)
car2 = Car(2000, 5, "Not Full", 105)
car3 = Car(2000, 15, "Kind of Full", 95)
car4 = Car(2000, 25, "Full", 25)
car5 = Car(20000000, 35, "Empty", 15)