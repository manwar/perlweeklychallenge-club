#!/usr/bin/perl6
use v6;

use Test;

# 30.1
# Write a script to list dates for Sunday Christmas between 2019 and 2100. For example, 25 Dec 2022 is Sunday.

# Challenge #13.1
# Write a script to print the date of last Friday of every month of a given year. Order y, m, d
my @sundayxmas;

2019..2100 ==> map { Date.new($_,12,25) } ==> grep { $_.day-of-week==7} ==> map { say $_.yyyy-mm-dd } ; #
