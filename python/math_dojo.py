class MathDojo(object):
	def __init__(self, result = 0):
		self.result = result
	def add(self, *rest):
		# self.result += num
		# for data in rest:
		# 	self.result += data
		# return self

		for data in rest:
			if isinstance(data, list):
				for item in data:
					self.result += item
			elif isinstance(data, tuple):
				for item in data:
					self.result += item
			else:
				self.result += data
		return self

	def subtract(self, *rest):
		# self.result -= num
		# if (isinstance(self.rest, list)):
		# 	for data in rest:
		# 		self.rest
		# for data in rest:
		# 	self.result -= data
		# return self

		for data in rest:
			if isinstance(data, list):
				for item in data:
					self.result -= item
			elif isinstance(data, tuple):
				for item in data:
					self.result -= item
			else:
				self.result -= data
		return self




md = MathDojo().add([1], (3,4)).add([3, 5, 7, 8], [2, 4.3, 1.25]).subtract(2, [2,3], [1.1, 2.3]).result

print md