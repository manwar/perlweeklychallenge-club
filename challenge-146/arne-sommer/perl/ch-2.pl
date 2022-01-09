#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings qw(experimental::signatures);

my $fraction = $ARGV[0] // "";

die "Not a fraction: $fraction" unless $fraction =~ /^\d+\/\d+$/;

my $parent      = parent($fraction);
my $grandparent = parent($parent);

say "parent = \'$parent\' and grandparent = \'$grandparent\'";

sub parent ($fraction)
{
  my ($numerator, $denominator) = split("/", $fraction);
  
  return "0/0" if $numerator == 1 && $denominator == 1;

  $numerator < $denominator
    ? return $numerator . "/" . ( $denominator - $numerator )
    : return ($numerator - $denominator ) . "/" . $denominator;
}
