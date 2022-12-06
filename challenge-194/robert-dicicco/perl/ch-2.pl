#!/usr/bin/env perl

=begin pod

AUTHOR: Robert DiCicco

DATE:   2022-12-06

Challenge 194 Frequency Equalizer ( Perl )

------------------------------

SAMPLE OUTPUT

 perl .\FrequencyEqualizer.pl

Input: $s = abbc

Output: 1

------------------------------

Input: $s = xyzyyxz

Output: 1

------------------------------

Input: $s = xzxz

Output: 0

------------------------------

=cut

use strict;

use warnings;

use feature qw/say/;

use List::UtilsBy qw(max_by min_by);

 

my %seen = ();

 

my @ss = (("abbc"), ("xyzyyxz"), ("xzxz"));

my $x = 0;

 

foreach my $s (@ss) {

  say "Input: \$s = $s";

  my $ln = length($s);

  while( $x < $ln ) {

    my $zsub = substr($s,$x,1);

    $seen{$zsub} += 1;

    if ($x < $ln) {$x++};

  }

  my $highest = max_by { $seen{$_} } keys %seen;

  my $lowest  = min_by { $seen{$_} } keys %seen;

 

  ($seen{$lowest} + 1 == $seen{$highest}) ? say "Output: 1" : say "Output: 0";

  say "------------------------------";

  $x = 0;

  %seen = ();

}
