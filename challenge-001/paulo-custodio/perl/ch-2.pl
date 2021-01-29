#!/usr/bin/perl

# Challenge 001
#
# Challenge #2
# Write a one-liner to solve the FizzBuzz problem and print the numbers 1
# through 20. However, any number divisible by 3 should be replaced by the word
# ‘fizz’ and any divisible by 5 by the word ‘buzz’. Those numbers that are both
# divisible by 3 and 5 become ‘fizzbuzz’.

use strict;
use warnings;
use 5.030;

my $n = shift || 20;
for (1 .. $n) {
    say(($_%15)==0 ? "fizzbuzz" : ($_%3)==0 ? "fizz" : ($_%5)==0 ? "buzz" : $_);
}
