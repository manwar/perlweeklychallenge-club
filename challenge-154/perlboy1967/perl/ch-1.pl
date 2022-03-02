#!/bin/perl

=pod

The Weekly Challenge - 154
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-154/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Missing Permutation
Submitted by: Mohammad S Anwar

You are given possible permutations of the string 'PERL'.

PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
LPER, LPRE, LEPR, LRPE, LREP

Write a script to find any permutations missing from the list.

=cut

use v5.16;
use strict;

use Algorithm::Combinatorics qw(permutations);
use List::MoreUtils qw(singleton);

my @s = singleton(
  qw(
    PELR PREL PERL PRLE PLER PLRE EPRL EPLR
    ERPL ERLP ELPR ELRP RPEL RPLE REPL RELP 
    RLPE RLEP LPER LPRE LEPR LRPE LREP
  ),
  map{join '',@$_} permutations([split(//,'PERL')])
);

say "Missing permutation(s): (",join(',',@s),")";

