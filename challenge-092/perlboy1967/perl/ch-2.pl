#!/usr/bin/perl

# Perl Weekly Challenge - 092
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-092/
#
# Task 2 - Insert Interval
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use Interval;
use List::Util qw(min max);

# Unbuffered STDOUT
$|++;

while(<DATA>) {
  chomp;
  next if /#/;
  my @d = split(/\s+/);
  my @i = map { Interval->new(split(/,/,$_)) } @d;
  my $n = pop(@i);

  Print('Input', @i, $n);

  my $ext = 0;
  my @o = map {
    # Extend when overlaps
    if ($_->overlaps($n)) {
      $_ = Interval->new(min($_->min,$n->min),
                         max($_->max,$n->max));
      $ext++;
    }
    $_;
  } @i;

  push(@o, $n) unless $ext;

  @o = sort { $a->cmp($b) } @o;

  my $i = 0;
  while ($i <= scalar(@o) - 2) {
    # splice overlapping entries
    if ($o[$i]->overlaps($o[$i+1])) {
      splice(@o, $i, 2, 
           Interval->new(min($o[$i]->min,$o[$i+1]->min),
                         max($o[$i]->max,$o[$i+1]->max)));
    } else {
      $i++;
    }
  }

  Print('Output', @o);
}
  
sub Print {
  my ($label,@val) = @_;

  if ($label eq 'Input') {
    my $n = pop(@val);
    printf "%s \$S = %s; \$N = %s\n", 
           $label, join(', ',map { $_->string } @val), $n->string;
  } else {
    printf "%s %s\n",
           $label, join(', ',map { $_->string } @val);
  }
}

# Test data
__DATA__
1,4 8,10		2,6
1,2 3,7 8,10		5,8
1,5 7,9			10,11
3,4 5,6 8,10		0,1
3,4 8,10 5,6		1,3
3,4 8,10 5,6		1,12
