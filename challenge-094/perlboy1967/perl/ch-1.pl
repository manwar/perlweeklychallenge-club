#!/usr/bin/perl

# Perl Weekly Challenge - 094
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-094/
#
# Task 1 - Group Anagrams
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

use List::Util qw(shuffle);

# Unbuffered STDOUT
$|++;

while (<DATA>) {
  chomp();
  my @words = map { s/\s*(\S+)\s*/$1/; $_ } split(/,/);

  my %anagrams;

  foreach my $word (@words) {
    my $k = join('',sort split //, $word);
    push(@{$anagrams{$k}}, $word);
  }

  printf "-------------------------------------------\n";
  printf "Input: (%s)\n", join('"),("', @words);
  printf "Output:\n";
  printf "\t%s\n", join("\n\t", 
                        map { 
                          join(',', shuffle @{$anagrams{$_}})
                        } shuffle keys %anagrams);
  printf "-------------------------------------------\n";
}

__DATA__
opt,bat,saw,tab,pot,top,was
x
stet,tips,test,pits,bal,spit,lab
