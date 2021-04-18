#! /usr/bin/env perl

use strict;
use warnings;

use feature 'say';

my $count = $ARGV[0] // 10;

say 1; exit if $count == 1;
say 1; exit if $count == 2;

my @first = (1);
my @triangle = (\@first);
my $row = 0;

while ($count-- > 0)
{
  $row++;
  my @prev = @{$triangle[$row-1]};
  my @new  = $prev[-1];

  for my $index (0 .. @prev -1)
  {
    push(@new, $new[-1] + $prev[$index]);
  }
   
  push(@triangle, \@new);

  say $new[-1];
}
