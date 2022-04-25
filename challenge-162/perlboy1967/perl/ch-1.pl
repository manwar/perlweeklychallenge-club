#!/bin/perl

=pod

The Weekly Challenge - 162
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-162/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: ISBN-13
Submitted by: Mohammad S Anwar

Write a script to generate the check digit of given ISBN-13 code. Please refer to 
wikipedia for more information.

=cut

use v5.16;

use List::Util qw(sum0);
use List::MoreUtils qw(pairwise);

my @isbnDigits = (grep/\d/,split//,shift // '978-0-306-40615-7')[0..11];
my @factors = split//,1313131313131;
say -(sum0 pairwise {$a*$b} @isbnDigits,@factors) % 10;
