import unittest
from underscore import Underscore

class UnderscoreTest(unittest.TestCase):
    def setUp(self):
        # create an instance of the Underscore module we created
        self._ = Underscore()
        # initialize a list to run our tests on
        self.test_list = [1,2,3,4,5]
        self.map_result = self._.map(self.test_list, lambda x: x + 2)
        self.test_list = [1,2,3,4,5]
        self.reduce_result = self._.reduce(self.test_list, lambda x,y: x + y, 0)
        self.find_result = self._.find(self.test_list, lambda x: x % 3 == 0)
        self.not_found = self._.find(self.test_list, lambda x: x % 7 == 0)
        self.filter_result = self._.filter(self.test_list, lambda x: x % 2 == 0)
        self.reject_result = self._.reject(self.test_list, lambda x: x % 2 == 0)

    def testMap(self):
        return self.assertEqual([3, 4, 5, 6, 7], self.map_result)
    def testReduce(self):
        return self.assertEqual(15, self.reduce_result)
    def testFind(self):
        return (self.assertEqual(3, self.find_result) and self.assertFalse(self.not_found))
    def testFilter(self):
        return self.assertEqual([2,4], self.filter_result)
    def testReject(self):
        return self.assertEqual([1,3,5], self.reject_result)

if __name__ == "__main__":
    unittest.main()