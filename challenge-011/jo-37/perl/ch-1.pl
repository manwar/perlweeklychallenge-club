#!/usr/bin/perl

use v5.16;
use warnings;

# 212 F - 32 F = 180 degF = 100 K, i.e. 1.8 degF = 1 K
# Fahrenheit to Kelvin: (F - 32)/1.8 + 273.15
# Celsius to Kelvin: C + 273.15
# (x - 32)/1.8 + 273.15 = x + 273.15
# x - 32 = 1.8 * x
# -32 = 0.8 * x
# x = -40
say -40;
