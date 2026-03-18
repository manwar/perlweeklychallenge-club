#!/usr/bin/env perl

# Perl Weekly Challenge 313 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-313/

use Modern::Perl;

say reverse_letters(shift);

sub reverse_letters {
    my($string) = @_;
    my @rev_letters = reverse grep {/[a-z]/i} split //, $string;
    my @output = split //, $string;
    for my $i (0 .. $#output) {
        next if $output[$i] !~ /[a-z]/i;
        $output[$i] = shift @rev_letters;
    }
    return join '', @output;
}
