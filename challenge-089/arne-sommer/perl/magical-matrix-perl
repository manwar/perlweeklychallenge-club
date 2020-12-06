#! /usr/bin/env perl

use strict;
use feature 'say';
use Getopt::Long;
use Algorithm::Combinatorics 'permutations';

my $verbose = 0;
my $all     = 0;

GetOptions("verbose"  => \$verbose,
           "all"      => \$all);

my @source = 1..9;

for my $list (permutations(\@source))
{
  my @candidate = @$list;
  say ":: " . join(@candidate, ", ") if $verbose;
  my ($a, $b, $c, $d, $e, $f, $g, $h, $i) = @candidate;

  next unless $a + $b + $c == 15;
  next unless $d + $e + $f == 15;
  next unless $g + $h + $i == 15;
  next unless $a + $d + $g == 15;
  next unless $b + $e + $h == 15;
  next unless $c + $f + $i == 15;
  next unless $a + $e + $i == 15;
  next unless $c + $e + $g == 15;

  say "[ " . join(" ", @candidate[0..2]) . " ]";
  say "[ " . join(" ", @candidate[3..5]) . " ]";
  say "[ " . join(" ", @candidate[6..8]) . " ]";
  say "" if $all;

  last unless $all;
}
