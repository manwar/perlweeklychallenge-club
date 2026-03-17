#!/usr/bin/env perl

# Perl Weekly Challenge 273 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/

use Modern::Perl;

say percent_char(@ARGV);

sub percent_char {
    my($str, $ch) = @_;
    my $percent = 100 * ($str =~ s/$ch/$ch/g) / length($str);
    return int($percent+0.5);
}
