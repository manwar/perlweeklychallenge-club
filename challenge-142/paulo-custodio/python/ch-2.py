#!/usr/bin/python3

# TASK #2 > Sleep Sort
# Submitted by: Adam Russell
# Another joke sort similar to JortSort suggested by champion Adam Russell.
#
# You are given a list of numbers.
#
# Write a script to implement Sleep Sort. For more information, please checkout
# this post.

import sys
import threading
from time import sleep

def sleeper(n):
    sleep(n)
    print(n)

thrs = []
for n in [int(x) for x in sys.argv[1:]]:
    thr = threading.Thread(target=sleeper, args=[n])
    thrs.append(thr)
    thr.start()
for thr in thrs:
    thr.join()
