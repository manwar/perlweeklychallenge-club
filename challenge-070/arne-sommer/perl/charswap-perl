#! /usr/bin/env perl

use strict;
use feature 'say';

my $verbose = 0;

if (@ARGV && $ARGV[0] eq "--verbose")
{
  $verbose = 1;
  shift(@ARGV);
}

my $S = shift(@ARGV) // 'perlandraku';
my $N = length $S;
my $O = shift(@ARGV) // 4;
my $C = shift(@ARGV) // 3;

die '$O: Integer >= 1 only'  unless int $O == $O;
die '$C: Integer >= 1 only'  unless int $C == $C;
die '$C: Must be < $O'       unless $C < $O;
die '$C + $O: Must be <= $N' unless $C + $O <= $N;

for my $index (1 .. $C)
{
  say "swap $index: " . substr($S, $index, 1) . " <-> " . substr($S, $index + $O, 1) . " == $S" if $verbose;

  (substr($S, $index,1), substr($S, $index + $O,1) ) =
  (substr($S, $index + $O, 1), substr($S, $index, 1));
}

say $S;
