#!/bin/perl

=pod

The Weekly Challenge - 139
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-139/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Add Binary
Submitted by: Mohammad S Anwar

You are given two decimal-coded binary numbers, $a and $b.

Write a script to simulate the addition of the given binary numbers.

  ||  The script should simulate something like $a + $b. (operator overloading)

=cut

use v5.16;
use strict;
use warnings;

my $b1 = new myBin(0b001);
my $b2 = new myBin(0b101);
my $b3 = new myBin(0b011);

printf "b1: %s, b2: %s, b3: %s\n", $b1, $b2, $b3;

my $A = new myBin($b3);
printf "A: %s\n", $A;

my $B = new myBin($b1 + 7);
printf "B: %s (%s + 7)\n", $B, $b1;
$B += $b2;
printf "B: %s (%s + 7 + %s)\n", $B, $b1, $b2;
$B += $b3;
printf "B: %s (%s + %s + %s)\n", $B,  $b1, $b2, $b3;
$B = $b1 + $b3;
printf "B: %s (%s + %s)\n", $B, $b1, $b3;
$B = 9 + $b1;
printf "B: %s (%s + %s)\n", $B, 9, $b1;


package myBin;

use List::MoreUtils qw(pairwise);

use overload 
  '""' => sub { '0b'.join '',reverse @{$_[0]} },
  '+' => \&_plus; 

sub new {
  my ($self,$arg) = @_;

  # Accept a myBin object to initialize
  # or an integer number  
  my @data = ();
  if (defined $arg) {
    if (ref $arg) {
      @data = @$arg;
    } else {
      @data = reverse split //,sprintf '%b', $arg;
    }
  }

  bless \@data,$self;
}

sub _plus { 
  my ($self, $other) = @_;

  $other = new myBin($other) if (!ref $other);

  my ($carry,$res) = (0);
  my @result = pairwise {
    no warnings 'once';
    $res = ($a//0) + ($b//0) + $carry;
    $carry = ($res >> 1);
    $res &= 1;
  } @$self, @$other;
  push(@result,1) if $carry;

  bless \@result;
}

1;
