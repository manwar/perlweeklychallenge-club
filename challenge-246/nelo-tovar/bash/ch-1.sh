#!/usr/bin/env bash 
#
# The Weekly Challenge 246 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/
#
# Task 1 : 6 out of 49 

min=6
max=49
amount=6

shuf -i $min-$max -n $amount | sort -n
