#! /usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;
use feature 'say';
use feature 'signatures';

no warnings qw(experimental::signatures);

my $verbose = 0;

GetOptions("verbose"  => \$verbose);

my $interval = $ARGV[0] // die 'Please specify one or more intervals';

my @Intervals = split(/\s+|\s+/, $interval);

sub does_intersect($first, $second)
{
  my ($first_from,  $first_to)  = split(",", $first);
  my ($second_from, $second_to) = split(",", $second);

  return 0 if $first_to  < $second_from;
  return 0 if $second_to < $first_from;
  return 1;
}

my @done;
my @conflict;

for my $interval (@Intervals)
{
  say ": Inspecting interval: $interval" if $verbose;
  
  for my $iv (@done)
  {
    if (does_intersect($interval, $iv))
    {
      push(@conflict, $interval);
      last;
    }
  }

  push(@done, $interval);
} 

say '[ ', join(", ", map { "($_)" } @conflict), ' ]';
