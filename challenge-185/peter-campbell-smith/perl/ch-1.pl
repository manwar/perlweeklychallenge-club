#!/usr/bin/perl

# Peter Campbell Smith - 2022-10-02
# PWC 185 task 1

use v5.28;
use utf8;
use warnings;

# You are given MAC address in the form hhhh.hhhh.hhhh.
# Write a script to convert the address to the form hh:hh:hh:hh:hh:hh.

# Blog: https://pjcs-pwc.blogspot.com/2022/10/manipulating-characters.html

my (@tests, $test);

@tests = ('1ac2.34f0.b1c2', 'abc1.20f1.345a');

# just do it
for $test (@tests) {
	say $test =~ m|^(..)(..).(..)(..).(..)(..)$| ? qq[\nInput:  $test\nOutput: $1:$2:$3:$4:$5:$6]: 'Invalid format';
}
