#! /usr/bin/env perl

use strict;
use feature 'say';
use Math::Matrix;
use File::Slurp;

die "Specify a matrix file" unless $ARGV[0];

my @rows;

for my $line (read_file($ARGV[0], chomp => 1))
{
  $line =~ /\[ +(.*) \]/;
  my @values = split(",? +", $1);
  push(@rows, \@values);
}

my $m = Math::Matrix->new(@rows);

my @spiral;

while ($m->nrow())
{
  my $row = $m->getrow(0);

  push(@spiral, @{@{$row}[0]});
  $m = $m->delrow(0);
  $m = $m->rot90();
}

say '[ ', join(', ', @spiral), ' ]';
