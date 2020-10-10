#!/usr/bin/perl

# Perl Weekly Challenge - 081
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-081/
#
# Task 2 - Frequency Sort
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(min max);
use List::MoreUtils qw(uniq);

my $input = qq(
West Side Story

The award-winning adaptation of the classic romantic tragedy "Romeo and Juliet". The feuding families become two warring New York City gangs, the white Jets led by Riff and the Latino Sharks, led by Bernardo. Their hatred escalates to a point where neither can coexist with any form of understanding. But when Riff's best friend (and former Jet) Tony and Bernardo's younger sister Maria meet at a dance, no one can do anything to stop their love. Maria and Tony begin meeting in secret, planning to run away. Then the Sharks and Jets plan a rumble under the highway--whoever wins gains control of the streets. Maria sends Tony to stop it, hoping it can end the violence. It goes terribly wrong, and before the lovers know what's happened, tragedy strikes and doesn't stop until the climactic and heartbreaking ending.
);

my %input;

map { $input{$_}++ } grep /../, split(/[^A-Za-z]+/, $input);
foreach my $count (sort { $a <=> $b } uniq(values %input)) {
  printf "$count %s\n", join(' ', sort grep { $input{$_} == $count } keys %input);
}
