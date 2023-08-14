#!/usr/bin/env python3

from src import two_out_of_three as tt

if __name__ == '__main__':
    print(tt.two_out_of_three([1, 1, 2, 4], [2, 4], [4]))
    print(tt.two_out_of_three([4, 1], [2, 4], [1, 2]))
