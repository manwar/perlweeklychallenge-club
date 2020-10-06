#!/usr/bin/perl

# Perl Weekly Challenge - 081
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-081/
#
# Task 1 - Common Base String
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

@ARGV = qw(abcdabcd abcdabcdabcdabcd)
  unless (scalar @ARGV >= 2);

my ($A, $B) = @ARGV;

my @output;
foreach my $l (1 .. length($A)) {
  my $substr = substr($A, 0, $l);
  push(@output, $substr) 
    if ($B =~ m#($substr)($substr)#);
}

printf "Input:\n";
printf "\t\$A = '%s'\n", $A;
printf "\t\$B = '%s'\n", $B;
printf "\n";
printf "Output:\n";
printf "\t(%s)\n",(scalar @output ? '"'.join('","', @output).'"' : 'undef');
