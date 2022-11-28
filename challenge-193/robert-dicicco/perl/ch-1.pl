#!/usr/bin/env perl

=begin pod

AUTHOR: Robert DiCicco

DATE: 2022-11-28

Challenge 193 Binary String ( Perl )

 

Write a script to find all possible binary numbers of size $n.

Example 1

 

Input: $n = 2

Output: 00, 11, 01, 10

 

Example 2

 

Input: $n = 3

Output: 000, 001, 010, 100, 111, 110, 101, 011

------------------------------------------------------

SAMPLE OUTPUT

perl .\BinaryString.pl

Input: $n = 2

Output: 00 01 10 11

 

Input: $n = 3

Output: 000 001 010 011 100 101 110 111

=cut

 

use strict;

use warnings;

use boolean;

use feature qw/say/;

 

my @arr = (2,3);

 

for my $n (@arr) {

  say "Input: \$n = $n";

  my $x = 0;

  print "Output: ";

  while ( true ) {

    my $str = sprintf ("%0*b", $n,$x);

    if(length($str) > $n) {

      last;

    }

    print "$str ";

    $x++;

  }

  say "\n";

}
