#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <quoted string> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub rot($nr,$c) {
    return (ord $c >= 65 && ord $c <= 90) ? (chr(ord('A') + (ord($c) - ord('A') - ($nr % 26)) % 26)) : $c
}

my ($str,$nr) = @ARGV;
say join "", map {rot($nr,$_)} (split //, $str);
