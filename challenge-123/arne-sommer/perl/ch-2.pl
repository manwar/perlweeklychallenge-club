#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Scalar::Util qw(looks_like_number);

my $verbose = 0;

GetOptions("verbose" => \$verbose);

my @args;

for my $val (@ARGV)
{
  if ($val =~ /\,/)
  {
    my ($a, $b) = split(/\,/, $val);
    push(@args, $a, $b);
  }
  else
  {
    push(@args, $val);
  }
}

die "Wrong number of arguments" unless @args  == 8;

map { die "$_: Not a numeric value" unless looks_like_number($_) } @args;

my ($x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4) = @args;

my $l12 = sqrt(abs($x2 - $x1) ** 2 + abs($y2 - $y1) ** 2);
my $l23 = sqrt(abs($x3 - $x2) ** 2 + abs($y3 - $y2) ** 2);
my $l34 = sqrt(abs($x4 - $x3) ** 2 + abs($y4 - $y3) ** 2);
my $l41 = sqrt(abs($x1 - $x4) ** 2 + abs($y1 - $y4) ** 2);

unless ($l12 == $l23 && $l34 == $l41 && $l12 == $l41)
{
  say ": The four edges does not have the same length ($l12, $l23, $l34, $l41)" if $verbose;
  say 0;
  exit;
}

if ($l12 == 0)
{
  say ": All the points have the same position" if $verbose;
  say 0;
  exit;
}

my $dot_product = ($x2 - $x1) * ($y2 - $y1) + ($x4 - $x1) * ($y4 - $y1);

if ($dot_product)
{
  say ": Not 90 Degrees between lines 1-2 and 1-4" if $verbose;
  say 0;
  exit;
}

if ($x1 == $x3 && $y1 == $y3)
{
  say ": Point 1 and 3 are equal" if $verbose;
  say 0;
  exit;
}

say 1;
