#!/usr/bin/env python3

import two_out_of_three as tt

def test_2_returned():
    assert tt.two_out_of_three([1, 1, 2, 4], [2, 4], [4]) == [2, 4]

def test_3_returned():
    assert tt.two_out_of_three([4, 1], [2, 4], [1, 2]) == [1,2,4]
