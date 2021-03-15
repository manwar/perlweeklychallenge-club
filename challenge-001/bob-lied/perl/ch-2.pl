#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 001, Task #2 FizzBuzz
# Write a one-liner to solve the FizzBuzz problem and print the numbers 1
# through 20. However, any number divisible by 3 should be replaced by the
# word ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that
# are both divisible by 3 and 5 become ‘fizzbuzz’.
#=============================================================================

use strict;
use warnings;
use 5.020;

say ($_%15==0 ? 'fizzbuzz' : $_%5==0 ? 'buzz' : $_%3==0 ? 'fizz' : $_) foreach 1..20
