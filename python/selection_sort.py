import math

def selection_sort(sort_list):
	count = math.floor(len(sort_list)/2)
	index = 0;
	last_index = len(sort_list)
	while (count > 0):
		minimum = min(sort_list[index : last_index - index])
		maximum = max(sort_list[index : last_index - index])
		min_index = sort_list.index(minimum)
		max_index = sort_list.index(maximum)
		end_index = last_index - index - 1
		sort_list[min_index], sort_list[index] = sort_list[index], sort_list[min_index] 
		sort_list[max_index], sort_list[end_index] = sort_list[end_index], sort_list[max_index] 
		count -= 1
		index += 1

my_list = [3, 2, 4, 5, 1]

selection_sort(my_list)

print my_list

import random
my_random_list = random.sample(xrange(10001), 100)

bubble_sort(my_random_list)