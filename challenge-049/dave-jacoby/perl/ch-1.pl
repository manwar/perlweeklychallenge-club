#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use Carp;

my $number = int $ARGV[0];
croak 'Not a positive number' unless $number > 0;

my $smallest = smallest_multiple( $number);

say qq{The smallest multiple of $number containing just 0 and 1 is $smallest};
exit;


sub smallest_multiple( $n ) {
    my $dec = 1;
    while ( 1 ) {
        my $bin = sprintf '%b', $dec;
        return $bin if $bin % $n == 0 ;
        $dec++;
    }
}

__DATA__
Smallest Multiple

Write a script to accept a positive number as 
command line argument and print the smallest 
multiple of the given number consists of digits 0 and 1.

For example:
For given number 55, the smallest multiple is 110 
consisting of digits 0 and 1.
