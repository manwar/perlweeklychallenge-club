#! /usr/bin/env perl

use strict;
use feature 'say';

use Getopt::Long;
use List::Util qw(all sum);
use Algorithm::Combinatorics 'combinations';
    
my $verbose = 0;

GetOptions("verbose"  => \$verbose);

die "At least 3 values" unless @ARGV > 2;
die "Only positive Real numbers" unless all { $ ~= /^\d+(\.\d+)?$/ } @ARGV;
    
say ": ARGS: ", join(", ", @ARGV) if $verbose;

for my $combination (combinations(\@ARGV, 3))
{
  my $sum = sum(@$combination);
    
  say "Comb: ", join(", ", @$combination), " sum: $sum" if $verbose;

  if ($sum > 1 && $sum < 2)
  {
    say 1;
    exit;
  }
}

say 0;
