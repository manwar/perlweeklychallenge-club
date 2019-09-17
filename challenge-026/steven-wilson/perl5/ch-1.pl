#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-09-16
# Week: 026

# Task #1
# Create a script that accepts two strings, let us call it, “stones” and
# “jewels”. It should print the count of “alphabet” from the string
# “stones” found in the string “jewels”. For example, if your stones is
# “chancellor” and “jewels” is “chocolate”, then the script should print
# “8”. To keep it simple, only A-Z,a-z characters are acceptable. Also
# make the comparison case sensitive.
# usage: $ perl ch-1.pl chancellor chocolate
# output: 8


use strict;
use warnings;
use feature qw/ say /;

my ($stones, $jewels) = @ARGV;

my %alphabet = map { $_ => 0 } split //, $stones;

my $count = grep { exists $alphabet{$_} } split //, $jewels;

say $count;
