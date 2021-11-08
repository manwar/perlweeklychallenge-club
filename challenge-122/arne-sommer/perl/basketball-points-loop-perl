#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
use Getopt::Long;

no warnings qw(experimental::signatures);

my $upper = 3;

GetOptions("upper=i" => \$upper);

die "--upper must be > 0" if $upper < 1;

my $S = $ARGV[0] // die "Please specify a positive integer";

recurse($S);

sub recurse ($left, @points)
{
  $left == 0 && ( say join(" ", @points) ) && return;

  for my $step (1 .. $upper)
  {
    recurse($left - $step, @points, $step) if $left >= $step;
  }
}
