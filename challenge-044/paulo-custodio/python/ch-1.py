#!/usr/bin/env python3

# Challenge 044
#
# TASK #1
# Only 100, please.
# You are given a string "123456789". Write a script that would insert
# "+" or "-" in between digits so that when you evaluate, the result should
# be 100.

for a in ['', '-', '+']:
    for b in ['', '-', '+']:
        for c in ['', '-', '+']:
            for d in ['', '-', '+']:
                for e in ['', '-', '+']:
                    for f in ['', '-', '+']:
                        for g in ['', '-', '+']:
                            for h in ['', '-', '+']:
                                test = f"1{a}2{b}3{c}4{d}5{e}6{f}7{g}8{h}9"
                                res = eval(test)
                                if res==100:
                                    print(test)
