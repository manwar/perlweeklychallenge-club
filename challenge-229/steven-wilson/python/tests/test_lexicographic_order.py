#!/usr/bin/env python3

import lexicographic_order as lo

def test_1_not_in_order():
    assert lo.not_in_order( ["abc", "bce", "cae"] ) == 1

def test_2_not_in_order():
    assert lo.not_in_order( ["yxz", "cba", "mon"] ) == 2
