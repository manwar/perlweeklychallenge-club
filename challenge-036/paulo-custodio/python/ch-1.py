#!/usr/bin/env python3

# Challenge 036
#
# TASK #1
# Write a program to validate given Vehicle Identification Number (VIN).
# For more information, please checkout wikipedia.

import sys
from vininfo import Vin

vin = Vin(sys.argv[1])
print(1 if vin.verify_checksum() else 0)
