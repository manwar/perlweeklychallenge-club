#!/usr/bin/env perl

=begin pod

AUTHOR: Robert DiCicco

DATE  : 2022-12-14

Challenge 195 Most Frequent Even ( Perl )

 

SAMPLE OUTPUT

perl MFE.pl

Input: [1 1 2 6 2]

Output: 2

 

Input: [1 3 5 7]

Output: -1

 

Input: [6 4 4 6 1]

Output: 4

-----------------------------------------------

=cut

use strict;

use warnings;

use feature qw/say/;

 

my @nn = ([1,1,2,6,2], [1,3,5,7], [6,4,4,6,1] );

 

for my $n (@nn) {

  my %seen = ();

  print("Input: [@$n]\n");

  foreach my $x (@$n) {

    next if ($x =~ /^\d*[13579]$/);

    (exists $seen{$x}) ? ($seen{$x}++) : ($seen{$x} = 1);

  }

  if ((keys %seen) == 0) {print"Output: -1\n\n";next;}

 

  my @heights = reverse(sort { $seen{$a} <=> $seen{$b} } keys %seen);

  print("Output: $heights[0]\n\n");

}
