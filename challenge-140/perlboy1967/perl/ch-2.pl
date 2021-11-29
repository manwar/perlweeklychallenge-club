#!/bin/perl

=pod

The Weekly Challenge - 140
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-140/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Multiplication Table
Submitted by: Mohammad S Anwar

You are given 3 positive integers, $i, $j and $k.

Write a script to print the $kth element in the sorted multiplication table of $i and $j.

=cut

use v5.16;
use strict;
use warnings;

use List::MoreUtils qw(arrayify);
my($i,$j,$k)=@ARGV;
printf"%s\n",(sort{$a<=>$b}arrayify map{my$n=$_;$_=[map{$n*$_}1..$j]}1..$i)[$k-1];
