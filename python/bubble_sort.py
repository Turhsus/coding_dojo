def bubble_sort(sort_list):
	is_sorted = False
	while (not is_sorted):
		is_sorted = True
		for index, val in enumerate(sort_list):
			if index < (len(sort_list) - 1):
				if (sort_list[index] > sort_list[index + 1]):
					sort_list[index], sort_list[index + 1] = sort_list[index + 1], sort_list[index]
					is_sorted = False
					

my_list = [5, 7, 2, 4, 12, 9]

bubble_sort(my_list)

print my_list

import random
my_random_list = random.sample(xrange(10001), 100)

bubble_sort(my_random_list)

print my_random_list

# print ("Time: " % (time.time() - start_time))