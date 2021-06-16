#!/usr/bin/perl

# Perl Weekly Challenge - 117
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-117/#TASK1
#
# Task 1 - Missing Row(s)
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use File::Slurp;
use List::MoreUtils qw(slide);

printf "Missing row number(s) of file '%s' is/are '%s'\n", $ARGV[0], join(',',missingRows($ARGV[0]));


sub missingRows {
  my ($f) = @_;

  return grep /\d/,slide{($a+1..$b-1)if($b-$a>1)}sort{$a<=>$b}map{chomp;s/^(\d+).*/$1/;$_}read_file($f);
}
