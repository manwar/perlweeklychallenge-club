#!/usr/bin/env perl

# Perl Weekly Challenge 249 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/

use Modern::Perl;

my @pairs = make_pairs(@ARGV);
print_pairs(@pairs);

sub make_pairs {
    my(@ints) = @_;
    my @pairs;
    if (@ints == 0 || (@ints % 2) == 1) {
        return ();
    }
pair:
    while (@ints) {
        my $a = 0;
        for my $b (1 .. $#ints) {
            if ($ints[$a] == $ints[$b]) {
                push @pairs, [$ints[$a], $ints[$b]];
                splice @ints, $b, 1;
                shift @ints;
                next pair;
            }
        }
        return ();
    }
    return @pairs;
}

sub print_pairs {
    my(@pairs) = @_;
    say "(", join(", ", map {"(".$_->[0].", ".$_->[1].")"} @pairs), ")";
}
