#! /usr/bin/env perl

use strict;
use feature 'say';
use feature 'signatures';
no warnings 'experimental::signatures';
use Getopt::Long;

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my $N = shift(@ARGV) // die 'Please specify $N';

die '$N is not a positive integer' unless $N =~ /^[1-9][0-9]*$/;

my $lower = 1 . 0 x ($N -1);
my $upper = 9 x $N;

say ": Range: $lower - $upper" if $verbose;

for my $candidate ($lower .. $upper)
{
  say $candidate if is_rare($candidate);
}

sub is_rare ($number)
{
  my $reverse  = reverse $number;
  my $add      = $number + $reverse;
  my $subtract = $number - $reverse;

  return 0 if $add < 0 || $subtract < 0;

  my $add_sqrt = sqrt($add);
  my $sub_sqrt = sqrt($subtract);

  return int($add_sqrt) == $add_sqrt && int($sub_sqrt) == $sub_sqrt;
}
