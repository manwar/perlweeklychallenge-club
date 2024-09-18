#!/usr/bin/perl
use v5.38;

sub max($first, $second) {
    return $first > $second ? $first : $second;
}

sub min($first, $second) {
    return $first < $second ? $first : $second;
}

my @ints = @ARGV;

while (scalar @ints > 1) {
    my @next;
    for my $i (1 .. scalar @ints - 1) {
        push @next, $i % 2 == 0
            ? max($ints[$i- 1], $ints[$i])
            : min($ints[$i - 1], $ints[$i])
        ;
    }
    @ints = @next;
}

say $ints[0];
