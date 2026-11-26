#!/usr/bin/env perl
use strict;
use warnings;

# Peel in dependency order. In the remaining words each key is unique:
# z marks zero, then w marks two, and so on.
my @peel = (
    [0, 'z', 'zero'],  [2, 'w', 'two'],   [4, 'u', 'four'],
    [6, 'x', 'six'],   [8, 'g', 'eight'], [3, 'h', 'three'],
    [5, 'f', 'five'],  [7, 's', 'seven'], [1, 'o', 'one'],
    [9, 'i', 'nine'],
);

sub reconstruct_digits {
    my ($text) = @_;
    my %letters;
    my @counts = (0) x 10;
    ++$letters{$_} for split //, $text;

    for my $step (@peel) {
        my ($digit, $key, $word) = @$step;
        my $count = $letters{$key} // 0;
        next unless $count;
        $counts[$digit] = $count;
        for my $letter (split //, $word) {
            ($letters{$letter} //= 0) -= $count;
            die "Missing letters for $word\n" if $letters{$letter} < 0;
        }
    }

    # Published example 2 contains one extra 'n'. Show unused letters on
    # stderr while preserving the requested digits on stdout.
    my $unused = join '', map { $_ x $letters{$_} } sort keys %letters;
    warn "Unused input letters: $unused\n" if length $unused;
    return join '', map { $_ x $counts[$_] } 0 .. 9;
}

die "Usage: perl ch-2.pl 'zroezerotwotwotwo' [...]\n" unless @ARGV;
print reconstruct_digits($_), "\n" for @ARGV;
