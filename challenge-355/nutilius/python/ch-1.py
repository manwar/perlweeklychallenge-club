#!/usr/bin/env python3
# See Task1 in https://theweeklychallenge.org/blog/perl-weekly-challenge-355/

def solution(number):
    
    rest = len(number) % 3


    # Align
    l1 = list( number if rest == 0 else (3 - rest) * " " + number)

    # Format
    result = ",".join("".join(v) for v in zip(l1[0::3], l1[1::3], l1[2::3]))

    pos = 3 - rest if rest > 0 else 0 
    return result[pos:]

def test(value):
    print(f'Test for value: {value}')
    print(f'Test result: {solution(value)}')
    print()

if __name__ == "__main__":

    test("1")
    test("12")
    test("123")
    test("1234")
    test("12345")
    test("123456")
    test("1234567")
