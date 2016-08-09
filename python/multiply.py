def multiplyByFive(list , num):
	b = []

	for index in range(0, len(list)):
		b.append(list[index] * num)
		
	return b

a = [2, 4, 10, 16, 27]
b = multiplyByFive(a, 5)
print b