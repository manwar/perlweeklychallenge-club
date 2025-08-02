#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.goat_latin('I love Perl'),
            'Imaa ovelmaaa erlPmaaaa'
        )
        self.assertEqual(
            ch_1.goat_latin('Perl and Raku are friends'),
            'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa'
        )
        self.assertEqual(
            ch_1.goat_latin('The Weekly Challenge'),
            'heTmaa eeklyWmaaa hallengeCmaaaa'
        )

    def test_ch_2(self):
        self.assertEqual(
            ch_2.bus_route([ch_2.Route(12, 11, 41), ch_2.Route(15, 5, 35)]),
            [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]
        )
        self.assertEqual(
            ch_2.bus_route([ch_2.Route(12, 3, 41), ch_2.Route(
                15, 9, 35), ch_2.Route(30, 5, 25)]),
            [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45,
                46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59]
        )


if __name__ == '__main__':
    unittest.main()
