#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        input_1 = ["Bach", ["C", "D", "E", "F♯", "G", "A", "B"], [7, 1, 6, 2, 5, 3, 4]]
        input_2 = ["Beethoven", ["C", "D", "F♯", "G", "A♭"], [1, 3, 5, 2, 4]]
        input_3 = ["Brahms", ["C", "D♭", "E♭", "F", "G", "A♭", "B♭", "C", "D"], [9, 3, 7, 1, 8, 5, 2, 6, 4] ]
        input_4 = ["Bruckner", ["G", "F♯", "B♭", "C", "D", "E♭", "F"], [4, 7, 2, 6, 1, 5, 3] ]
        input_5 = ["Berg", ["C♯"], [1]]

        self.assertEqual(ch_1.reorder_notes(*input_1), "BACH => D F♯ A B G E C")
        self.assertEqual(ch_1.reorder_notes(*input_2), "BEETHOVEN => C G D A♭ F♯")
        self.assertEqual(ch_1.reorder_notes(*input_3), "BRAHMS => F B♭ D♭ D A♭ C E♭ G C")
        self.assertEqual(ch_1.reorder_notes(*input_4), "BRUCKNER => D B♭ F G E♭ C F♯")
        self.assertEqual(ch_1.reorder_notes(*input_5), "BERG => C♯")

    def test_ch_2(self):
        self.assertEqual(ch_2.zigzag_subway([9, 4, 2, 10, 7, 8, 8, 1, 9]), 5)
        self.assertEqual(ch_2.zigzag_subway([1, 7, 4, 9, 2, 5]), 6)
        self.assertEqual(ch_2.zigzag_subway([1, 2, 3, 4, 5]), 2)
        self.assertEqual(ch_2.zigzag_subway([4, 4, 4]), 1)
        self.assertEqual(ch_2.zigzag_subway([10, 20, 15, 12, 18]), 3)


if __name__ == "__main__":
    unittest.main()
