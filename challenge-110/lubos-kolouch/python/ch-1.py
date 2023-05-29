#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re


def valid_phone_numbers(filename):
    with open(filename, 'r') as f:
        contents = f.readlines()

    valid_numbers = []

    for line in contents:
        if re.match(r"^(\+|\()?(\d{2,4})\)?(\s|\-)?\d{2,4}(\s|\-)?\d{2,4}(\s|\-)?\d{2,4}$", line.strip()):
            valid_numbers.append(line.strip())

    return valid_numbers


print(valid_phone_numbers('phone_numbers.txt'))
