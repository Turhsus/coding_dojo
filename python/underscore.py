class Underscore(object):
    def map(self, my_list, callback):
        squared_list = []
        for item in my_list:
            squared_list.append(callback(item))
        return squared_list
    def reduce(self, my_list, callback, identity):
        reduced = callback(my_list[0], identity)
        for item in my_list[1:]:
            reduced = callback(item, reduced)
        return reduced
    def find(self, my_list, predicate):
        for item in my_list:
            if predicate(item):
                return item
        return "Not Found!"
    def filter(self, my_list, predicate):
        filtered_list = []
        for item in my_list:
            if predicate(item):
                filtered_list.append(item)
        return filtered_list
    def reject(self, my_list, predicate):
        rejected_list = []
        for item in my_list:
            if not predicate(item):
                rejected_list.append(item)
        return rejected_list
# you just created a library with 5 methods!
# let's create an instance of our class
_ = Underscore() # yes we are setting our instance to a variable that is an underscore
print _.map([1, 3, 4, 5], lambda x: x * x)
print _.reduce([2, 3, 7], lambda x,y: x * y, 1)
print _.find([2, 12, 7, 9, 1], lambda x: x % 3 == 0)
print _.find([2, 1, 7, 9, 1], lambda x: x % 3 == 0)
print _.find([2, 1, 7, 1], lambda x: x % 3 == 0)
print _.filter([1, 2, 3, 4, 5, 6], lambda x: x % 2 == 0)
print _.reject([1, 2, 3, 4, 5, 6], lambda x: x % 2 == 0)


# should return [2, 4, 6] after you finish implementing the code above