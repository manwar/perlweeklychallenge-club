#!/usr/bin/env perl

# Perl Weekly Challenge 234 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-234/

use Modern::Perl;
use List::Util 'all';

my @words = @ARGV;
say join " ", find_common_chars(@words);

sub find_common_chars {
    my(@words) = @_;
    my @result;

    while (all {$_ ne ''} @words) {
        my $ch = substr($words[0],0,1);
        my $count;
        for (@words) {
            $count += s/$ch//i;
        }
        push @result, $ch if $count == @words;
    }
    return @result;
}
