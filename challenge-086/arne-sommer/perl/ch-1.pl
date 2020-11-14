#! /usr/bin/env perl

use strict;
use feature 'say';

use Getopt::Long;
use List::Util qw(all sum);
use Algorithm::Combinatorics 'combinations';
 
die "At least 3 values" unless @ARGV > 2;
die "Integers only" unless all { $ ~= /^\d+$/ } @ARGV;

my $A = shift(@ARGV);

for my $combination (combinations(\@ARGV, 2))
{
  my $sum = @$combination[0] - @$combination[1];


  if (abs($sum) == $A)
  {
    say 1;
    exit;
  }
}

say 0;
