def draw_stars(my_list):
	stars = ""
	for element in my_list:
		while element > 0:
			stars = stars + "*"
			element -= 1
		print stars
		stars = ""

draw_stars([4, 6, 1, 3, 5, 7, 25])

def draw_stars_letters(my_list):
	stars = ""
	letters = ""
	for element in my_list:
		if (isinstance(element, (int, long))):
			while element > 0:
				stars = stars + "*"
				element -= 1

			print stars
			stars = ""

		else:
			length = len(element)
			while length > 0:
				letters = letters + element[0]
				length -= 1
			print letters.lower()
			letters = ""

draw_stars_letters([4, "Tom", 1, "Michael", 5, 7, "Jimmy Smith"])