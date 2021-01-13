#! /usr/bin/env perl

use strict;
use feature 'say';
use List::Util qw(all uniq);
 
die "At least 1 value" unless @ARGV;
die "Integers only" unless all { $ ~= /^\-?\d+$/ } @ARGV;

my @sorted = uniq sort { $a <=> $b } @ARGV;

my @longest;
my $longest = 0;
my @current = shift(@sorted);
my $current = $current[0];

for my $num (@sorted)
{
  if ($num == $current + 1)
  {
    push(@current, $num);
    $current = $num;
  }
  else
  {
    if (@current > $longest)
    {
      @longest = @current;
      $longest = @longest;
    }
    $current = $num;
    @current = ($num);
  }
}

say @longest > 1
  ? "(" . join(", ", @longest) . ")"
  : "0";
