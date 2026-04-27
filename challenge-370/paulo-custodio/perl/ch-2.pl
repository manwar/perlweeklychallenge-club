#!/usr/bin/env perl

# Perl Weekly Challenge 370 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-370/

use Modern::Perl;

@ARGV==2 or die "usage: $0 word1 word2\n";
my($a, $b) = @ARGV;
say is_scramble($a, $b) ? "true" : "false";

sub is_anagram {
    my($a, $b) = @_;
    return (join '', sort split //, $a) eq (join '', sort split //, $b);
}


sub is_scramble {
    my ($a, $b) = @_;
    return 1 if $a eq $b;
    return 0 if length($a) != length($b);
    return 0 unless is_anagram($a, $b);

    my $n = length($a);

    for my $k (1 .. $n - 1) {
        my $a_left  = substr($a, 0, $k);
        my $a_right = substr($a, $k);

        # no swap
        if (is_scramble($a_left,  substr($b, 0, $k)) &&
            is_scramble($a_right, substr($b, $k))) {
            return 1;
        }

        # swap
        if (is_scramble($a_left,  substr($b, $n - $k)) &&
            is_scramble($a_right, substr($b, 0, $n - $k))) {
            return 1;
        }
    }

    return 0;
}
