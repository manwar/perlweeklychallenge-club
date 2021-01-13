#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 089 Challenge 2

=head1 SYNOPSIS

  $ ch-2.pl
  [ a b c ]
  [ d e f ]
  [ g h i ]

=head1 DESCRIPTION

A script to display matrix as below with numbers 1 - 9.

  [ a b c ]
  [ d e f ]
  [ g h i ]
  
The matrix will satisfy the following rules:

  a + b + c = 15
  d + e + f = 15
  g + h + i = 15
  a + d + g = 15
  b + e + h = 15
  c + f + i = 15
  a + e + i = 15
  c + e + g = 15
  
The numbers will only be used once.

=head1 SOLUTION

This solution uses the
L<Siamese method|https://en.wikipedia.org/wiki/Siamese_method> to populate and
print the array.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my @matrix;
my $LENGTH = 3;
my @location = (0, int($LENGTH / 2));
my $value = 1;
my $max_value = $LENGTH * $LENGTH + 1;

while ($value < $max_value) {
    
    if (!defined($matrix[$location[0]][$location[1]])) {
        $matrix[$location[0]][$location[1]] = $value++;
        $location[0] = ($location[0] - 1) % $LENGTH;
        $location[1] = ($location[1] + 1) % $LENGTH;
    } else {
        $location[0] = ((($location[0] + 1) % $LENGTH) + 1) % $LENGTH;
        $location[1] = ($location[1] - 1) % $LENGTH;
    }
}

foreach my $line (@matrix) {
    printf("[ %d %d %d ]\n", $line->[0], $line->[1], $line->[2]);
}

exit 0;
