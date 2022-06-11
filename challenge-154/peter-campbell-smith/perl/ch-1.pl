#!/usr/bin/perl

# Peter Campbell Smith - 2022-02-28
# PWC 154 task 1

use v5.28;
use strict;
use utf8;
use Algorithm::Combinatorics qw(permutations);

# You are given possible permutations of the string 'PERL'.
# Write a script to find any permutations missing from the list.

# Blog: https://pjcs-pwc.blogspot.com/2022/02/perming-perl-plus-padovan-primes.html

my ($given, $iter, $perm, $word);

$given = 'PELR, PREL, PERL, PRLE, PLER, PLRE, EPRL, EPLR, ERPL,
ERLP, ELPR, ELRP, RPEL, RPLE, REPL, RELP, RLPE, RLEP,
LPER, LPRE, LEPR, LRPE, LREP';

# get all permutations
$iter = permutations(['P', 'E', 'R', 'L']);

# print the one(s) that don't match $given
while ($perm = $iter->next) {
	$word = join('', @$perm);
	say $word unless $given =~ m|$word|;
}	
