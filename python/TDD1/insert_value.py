def insert_val_at(index, my_list, value):
    if index < 0 or index > len(my_list):
    	return False
    my_list.insert(index, value)
    return my_list