#!/usr/bin/env perl

# The Weekly Challenge 277 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/
#
# Task 1 - Count Common
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw /singleton one/;
use Data::Dump qw(dump);

my @examples = (
    [ ["Perl", "is", "my", "friend"], ["Perl", "and", "Raku", "are", "friend"] ],
    [ ["Perl", "and", "Python", "are", "very", "similar"], ["Python", "is", "top", "in", "guest", "languages"]  ],
    [ ["Perl", "is", "imperative", "Lisp", "is", "functional"], ["Crystal", "is", "similar", "to", "Ruby"] ],
);

sub count_common {
    my $elements=shift;
    my @words1 = singleton $elements->[0]->@*;
    my @words2 = singleton $elements->[1]->@*;
    my $count = 0;

    foreach my $word (@words1) {
        $count++ if one { $word eq $_ } @words2;
    }

    return $count;
}

for my $elements (@examples) {
    my $cc = count_common $elements;

    say 'Input : @words1 = ', dump(@$elements[0]);
    say '        @words2 = ', dump(@$elements[1]);
    say 'Output : ', $cc;
    say ' ';
}
