#!/usr/bin/env python
# -*- coding: utf-8 -*-

import threading
import time


def sleep_sort_value(n):
    time.sleep(n)
    print(n, end=' ')


def sleep_sort(numbers):
    threads = []

    for n in numbers:
        thread = threading.Thread(target=sleep_sort_value, args=(n,))
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()


sleep_sort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5])
