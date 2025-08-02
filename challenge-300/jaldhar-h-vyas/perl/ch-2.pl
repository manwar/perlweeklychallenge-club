#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

sub longestSet(@ints) {
    my $maxLength = 0;

    while (my ($i, $val) = each @ints) {
        my %seen;
        my $current = $i;
        my $length = 0;

        while (!$seen{$current}) {
            $seen{$current} = true;
            $current = $ints[$current];
            $length++;
        }

        if ($length > $maxLength) {
            $maxLength = $length;
        }
    }

    return $maxLength;
}

say longestSet(@ARGV);