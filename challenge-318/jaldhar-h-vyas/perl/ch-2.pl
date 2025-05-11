#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

my @source = split /\s+/, shift;
my @target = split /\s+/, shift;
my $result = false;

TOP: for my $i (0 .. scalar @source - 1) {
    for my $j ($i .. scalar @source - 1) {
        my @temp = @source;
        splice @temp, $i, $j - $i + 1, reverse @temp[$i..$j];

        if ((join q{}, @temp) eq (join q{}, @target)) {
            $result = true;
            last TOP;
        }
    }
}

say $result ? 'true' : 'false';
