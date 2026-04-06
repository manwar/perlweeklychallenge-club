#!/usr/bin/env perl

# Perl Weekly Challenge 368 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-368/

use Modern::Perl;

@ARGV==2 or die "usage: $0 number digit";
say remove_digit_max(@ARGV);

sub remove_digit_max {
    my ($num, $digit) = @_;
    my @chars = split //, $num;
    my $len = @chars;

    # Find earliest removable digit that improves the number
    for my $i (0 .. $len - 2) {
        if ($chars[$i] eq $digit && $chars[$i + 1] gt $digit) {
            splice(@chars, $i, 1);
            return join('', @chars);
        }
    }

    # Otherwise remove the last occurrence
    for (my $i = $len - 1; $i >= 0; $i--) {
        if ($chars[$i] eq $digit) {
            splice(@chars, $i, 1);
            last;
        }
    }

    return join('', @chars);
}
