#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-176/
($_ + reverse) =~ /^[13579]+$/ and print"$_\n" for 1..99;
