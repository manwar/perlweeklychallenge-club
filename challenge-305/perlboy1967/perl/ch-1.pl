#!/bin/perl

=pod

The Weekly Challenge - 305
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-305#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Binary Prefix
Submitted by: Mohammad Sajid Anwar

You are given a binary array.

Write a script to return an array of booleans where the partial binary number
up to that point is prime.

=cut

use v5.32;
use common::sense;
use feature qw(signatures);

use Test2::V0 qw(-no_srand);

no warnings qw(experimental::signatures);

use boolean;
use Math::Prime::XS qw(is_prime);

sub binaryPrefix (@bits) {
  my $b;
  [map {$b .= $_; boolean is_prime oct "0b$b" } @bits];
}

is(binaryPrefix(1,0,1),
               [false,true,true],'Example 1');
is(binaryPrefix(1,1,0),
               [false,true,false],'Example 2');
is(binaryPrefix(1,1,1,1,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,1),
               [0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],'Example 3');

done_testing;
