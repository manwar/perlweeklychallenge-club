#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $N = $ARGV[0] // "";

die "Please specify an integer in the range 1..255" if $N !~ /^[1-9]\d*$/ || $N > 255;

my $binary  = sprintf('%08b', $N);
my $swapped = substr($binary, 1, 1) .
              substr($binary, 0, 1) .
              substr($binary, 3, 1) .
              substr($binary, 2, 1) .
              substr($binary, 5, 1) .
              substr($binary, 4, 1) .
              substr($binary, 7, 1) .
              substr($binary, 6, 1);

if ($verbose)
{
  say ": Binary:  $binary";
  say ": Swapped: $swapped (binary)";
}

say oct("0b" . $swapped);
