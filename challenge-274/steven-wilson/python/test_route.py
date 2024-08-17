#!/usr/bin/env python3

from unittest import TestCase, main
from ch_2 import Route, bus_routes

class test_route(TestCase):

    def test_next_bus(self):
        route = Route(12, 11, 41)
        self.assertEqual(route.next_bus(10), 11)
        self.assertEqual(route.next_bus(12), 23)
        self.assertEqual(route.next_bus(23), 23)

    def test_end_trip(self):
        route = Route(12, 11, 41)
        self.assertEqual(route.end_trip(10), 52)

        route = Route(18, 0, 41)
        self.assertEqual(route.end_trip(59), 101)

class test_bus_routes(TestCase):

    def test_routes(self):
        self.assertEqual(bus_routes([ [12, 11, 41], [15, 5, 35] ]),
            [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47])
        self.assertEqual(bus_routes([ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]),
            [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59])

if __name__ == '__main__':
    main()
