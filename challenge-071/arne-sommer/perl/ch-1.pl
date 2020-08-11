#! /usr/bin/env perl

use strict;
use feature 'say';

my $N = shift(@ARGV) // die 'Please specify $N';
my $verbose;

if ($N eq "--verbose" || $N eq "--v")
{
  $verbose++;
  $N = shift(@ARGV) // die 'Please specify $N';
}

die '$N must be an integer >= 1' unless int($N) == $N && $N >= 1;

my @array;

push(@array, int(rand(50) +1)) for 1 .. $N;

say ": Values: " , join(", ", @array) if $verbose;

my @peak;

push(@array,    -1);
unshift(@array, -1);

for my $index (1 .. $N)
{
  say ": Checking at position $index: (left:" . $array[$index-1] . ", value: " . $array[$index] . ", right:" . $array[$index+1] . ")" if $verbose;
  push(@peak, @array[$index]) if $array[$index] > $array[$index-1] && $array[$index] > $array[$index+1];
}

say "[ ", join(", ", @peak), " ]";
