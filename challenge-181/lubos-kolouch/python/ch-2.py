#!/usr/bin/env python
# -*- coding: utf-8 -*-


def hot_days(filename: str):
    with open(filename, "r") as f:
        lines = f.readlines()

    temps = {}
    for line in lines:
        date, temp = line.strip().split(", ")
        temps[date] = int(temp)

    prev_temp = -1
    for date in sorted(temps.keys()):
        if temps[date] > prev_temp:
            print(date)
            prev_temp = temps[date]


hot_days("temperature.txt")
