#!/usr/bin/env perl6

# Perl Weekly Challenge 019
#
# Answer submitted by Jo Christian Oterhals
#
# Task 1
# Write a script to display months from the year 1900 to 2019 where you find 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.

say join "\n", grep *.day-of-week == 5, map { Date.new: |$_, 1 }, do 1900..2019 X 1,3,5,7,8,10,12;