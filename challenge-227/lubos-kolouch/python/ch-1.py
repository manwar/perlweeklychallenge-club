#!/usr/bin/env python
# -*- coding: utf-8 -*-

from datetime import datetime, timedelta


def friday_13ths(year):
    dt = datetime(year, 1, 1)
    friday_13_count = 0

    while dt.year == year:
        if dt.weekday() == 4 and dt.day == 13:
            friday_13_count += 1
        dt += timedelta(days=1)

    return friday_13_count


print(friday_13ths(2023))  # 2
