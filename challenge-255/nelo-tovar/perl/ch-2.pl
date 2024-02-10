#!/usr/bin/env perl

# The Weekly Challenge 255 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/
#
# Task 2 - Most Frequent Word
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw(frequency);
use Data::Dump qw(dump);

my @examples = (
    {p => 'Joe hit a ball, the hit ball flew far after it was hit.',
     w => 'hit'},
    {p => 'Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.',
     w => 'the'},
);

sub most_frequent_word {
    my ($p, $w) = @_;
    my @words = grep {$_ ne $w} split /\W/, $p;
    my %most_frequent = (max => 0, word => '') ;
    my %frequency = frequency @words;

    foreach my $k (keys %frequency) {
        if ($frequency{$k} > $most_frequent{max}){
            $most_frequent{word} = $k;
            $most_frequent{max} = $frequency{$k};
        }
    }

    return $most_frequent{word};
}

for my $elements (@examples) {
    my $mfw = most_frequent_word $elements->{p}, $elements->{w};

    say 'Input : $p = ', $elements->{p};
    say '        $w = ', $elements->{w};
    say 'Output : ', $mfw;
    say ' ';
}
