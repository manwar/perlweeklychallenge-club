#!/usr/bin/perl

# Challenge 029

# Task #2
# Write a script to demonstrate calling a C function. It could be any user
# defined or standard C function.

use Modern::Perl;
use Path::Tiny;

use Inline C => path("cmult.c")->slurp();

say sprintf("%.2f", cmult(@ARGV));
