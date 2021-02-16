#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use Getopt::Long;
use List::Util qw(sum);

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $S = shift(@ARGV);
my $T = shift(@ARGV);

die '"$S" must have length' unless length $S;
die '"$T" must have length' unless length $T;

my $S_length = length $S;
my $T_length = length $T;
my $binary   = '1' x $S_length;

my $max      = oct('0b' . $binary);
my $matches  = 0;

for my $current (1 .. $max)
{
  my $mask = sprintf("%0" . $S_length ."b", $current);

  if (sum(split(//, $mask)) != $T_length)
  {
    say ":   Skipped binary mask '{ $mask }' - wrong number of 1s" if $verbose;
    next;
  }

  my $candidate = join("", map { substr($mask, $_, 1) eq '1' ? substr($S, $_,1) : '' } (0 .. $S_length -1));

  if ($candidate eq $T)
  {
    $matches++;
    say ": + Match found with binary mask '$mask'." if $verbose;
  }
  else
  {
    say ":   Considering binary mask ' $mask' - no match" if $verbose;
  }
}

say $matches;


