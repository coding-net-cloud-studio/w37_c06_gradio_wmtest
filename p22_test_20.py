import unittest
from p20_demo import 快速排序

class Test快速排序(unittest.TestCase):

    def test_快速排序(self):
        self.assertEqual(快速排序([]), [])
        self.assertEqual(快速排序([1]), [1])
        self.assertEqual(快速排序([2, 1]), [1, 2])
        self.assertEqual(快速排序([3, 2, 1]), [1, 2, 3])
        self.assertEqual(快速排序([1, 1, 1]), [1, 1, 1])

if __name__ == '__main__':
    unittest.main()
