#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my $longest = 0;

while (scalar @ints > 1) {
    (join q{}, @ints) =~ /((?:01|10)+)/g;
    my $length = length($1) // 0;

    if ($length > $longest) {
        $longest = $length;
    }

    shift @ints;
}

say $longest;