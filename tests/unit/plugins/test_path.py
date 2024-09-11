import unittest


class Test(unittest.TestCase):

    def test_nothing(self):
        self.nothing = None
        self.assertIsNone(self.nothing)
        # To continue
