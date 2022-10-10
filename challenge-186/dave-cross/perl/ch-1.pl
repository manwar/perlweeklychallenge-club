#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

use List::MoreUtils 'mesh';

sub zip (\@\@) {
  my ($x, $y) = @_;

  return mesh(@$x, @$y);
}

my ($x, $y) = @ARGV;
my @x = split /\s+/, $x;
my @y = split /\s+/, $y;

say join ' ', zip(@x, @y);
say join ' ', zip(@y, @x);

