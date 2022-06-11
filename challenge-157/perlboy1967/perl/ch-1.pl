#!/bin/perl

=pod

The Weekly Challenge - 157
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-157/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Pythagorean Means
Submitted by: Mohammad S Anwar

You are given a set of integers.

Write a script to compute all three Pythagorean Means i.e Arithmetic Mean, 
Geometric Mean and Harmonic Mean of the given set of integers. Please refer 
to wikipedia page for more informations.

=cut

use v5.16;

use List::Util qw(sum);

@ARGV = (1,3,5,6,9) unless @ARGV;

sub aMean { sum(@_)/@_ }
sub gMean { my $g=1; map{$g*=$_}@_; abs($g)**(1/@_) }
sub hMean { @_/sum(map{1/$_}@_) }

printf "AM = %f, GM = %f, HM = %f\n",
  aMean(@ARGV), gMean(@ARGV), hMean(@ARGV);

