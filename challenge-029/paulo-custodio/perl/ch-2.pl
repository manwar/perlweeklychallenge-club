#!/usr/bin/perl

# Challenge 029

# Task #2
# Write a script to demonstrate calling a C function. It could be any user
# defined or standard C function.

use Modern::Perl;
use Inline C => <<'END';
    int sum(int a, int b) {
        return a+b;
    }
END

say sum(@ARGV);
