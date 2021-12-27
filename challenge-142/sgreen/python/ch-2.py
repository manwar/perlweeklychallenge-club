#!/usr/bin/env python

import sys
from time import sleep
from threading import Thread


def _sleep_sort(seconds):
    sleep(float(seconds))
    print(seconds)


def main(inputs):
    threads = []

    if any(float(x) < 0 for x in inputs):
        raise ValueError('You can sort negative numbers')

    for seconds in inputs:
        new_thread = Thread(target=_sleep_sort, args=(seconds,))
        threads.append(new_thread)
        new_thread.start()

    for t in threads:
        t.join()


if __name__ == '__main__':
    main(sys.argv[1:])
