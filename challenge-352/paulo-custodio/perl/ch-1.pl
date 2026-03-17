#!/usr/bin/env perl

# Perl Weekly Challenge 352 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/

use Modern::Perl;

@ARGV or die "usage: $0 strings...\n";
my @match = find_match(@ARGV);
say join ", ", @match;

sub find_match {
    my(@in) = @_;
    my @out;
    my %found;
    for my $word (@in) {
        if (grep {$_ ne $word && /$word/} @in) {
            push @out, $word unless $found{$word}++;
        }
    }
    return @out;
}
