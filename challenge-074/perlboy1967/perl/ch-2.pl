#!/usr/bin/perl

# Perl Weekly Challenge - 074
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/
#
# Task 2 - FNR Character 
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use Data::Dumper;
use Tie::IxHash;

my @test = qw(ababc xyzzyx abcabdeabefaf);

my ($S) = @ARGV;
$S //= $test[rand(scalar @test)];

my $O;
tie my %cf, 'Tie::IxHash';

foreach my $c (split(//, $S)) {
  $cf{$c}++;
  my @c = grep { $_ if $cf{$_} == 1 } keys %cf;
  $O .=  (scalar @c ? $c[-1] : '#');
}

printf "Input: \$S = '%s'\n", $S;
printf "Output:     '%s'\n", $O;
