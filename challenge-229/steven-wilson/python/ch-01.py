#!/usr/bin/env python3

from src import lexicographic_order as lo

if __name__ == '__main__':
    print(lo.not_in_order( ["abc", "bce", "cae"] ))
    print(lo.not_in_order( ["yxz", "cba", "mon"] ))
