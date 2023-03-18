#!/usr/bin/env python
# -*- coding: utf-8 -*-

for fahrenheit in range(-100, 213):
    celsius = (fahrenheit - 32) * 5 / 9
    if fahrenheit == celsius:
        print(
            f"The equal point in the Fahrenheit and Celsius scales is {fahrenheit} °F and {celsius} °C."
        )
        break
