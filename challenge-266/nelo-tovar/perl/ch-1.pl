#!/usr/bin/env perl

# The Weekly Challenge 266 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-266/
#
# Task 1 - Uncommon Words
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw(none singleton);
use Data::Dump qw(dump);

my @examples = (
    {line1 => 'Mango is sweet', line2 => 'Mango is sour' },
    {line1 => 'Mango Mango', line2 => 'Orange'},
    {line1 => 'Mango is Mango', line2 => 'Orange is Orange'},
);

sub uncommon_words {
    my @words1 = split / /, lc(shift); #line1;
    my @words2 = split / /, lc(shift); #line2;
    my @uniq1 = singleton @words1;
    my @uniq2 = singleton @words2;
    my @uncommons;

    foreach my $word (@uniq1) {
        push @uncommons, $word if none {$_ eq $word} @words2;
    }
    foreach my $word (@uniq2) {
        push @uncommons, $word if none {$_ eq $word} @words1;
    }
    
    return \@uncommons;
}

for my $elements (@examples) {
    my $uw = uncommon_words $elements->{line1}, $elements->{line2};

    say 'Input : line1 = ', $elements->{line1};
    say '        line2 = ', $elements->{line2};
    say 'Output : ', dump(@$uw);
    say ' ';
}
