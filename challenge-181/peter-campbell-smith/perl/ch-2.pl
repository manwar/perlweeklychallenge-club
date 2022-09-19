#!/usr/bin/perl

# Peter Campbell Smith - 2022-09-05
# PWC 181 task 2

use v5.28;
use utf8;
use warnings;

# You are given file with daily temperature record in random order.
# Write a script to find out days hotter than previous day.

# Blog: https://pjcs-pwc.blogspot.com/2022/09/alphabetical-and-days-hotter-sentences.html

my ($line, %input, $day, $yesterday);

# read the data into %input such that $input{date} = temp
while ($line = <DATA>) {
	$input{$1} = $2 if $line =~ m|(.+), (\d+)|;
}

# check each day against the previous one
$yesterday = 99;
for $day (sort keys %input) {
	say qq[$day was hotter ($input{$day}) than the previous day ($yesterday)] if $input{$day} > $yesterday;
	$yesterday = $input{$day};
}

__DATA__
2022-08-01, 20
2022-08-09, 10
2022-08-03, 19
2022-08-06, 24
2022-08-05, 22
2022-08-10, 28
2022-08-07, 20
2022-08-04, 18
2022-08-08, 21
2022-08-02, 25
