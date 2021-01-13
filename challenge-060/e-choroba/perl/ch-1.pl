#!/usr/bin/perl
use warnings;
use strict;

sub convert {
    my ($in) = @_;
    my $r;
    if ($in =~ /^[0-9]+$/) {
        $r = "";
        while ($in) {
            substr $r, 0, 0, chr(--$in % 26 + ord 'A');
            $in = int($in / 26);
        }

    } elsif ($in =~ /^[A-Z]+$/) {
        $r = 0;
        while ($in) {
            $r *= 26;
            $r += ord(substr $in, 0, 1, "") + 1 - ord 'A';
        }

    } else {
        die "Invalid input: $in!\n";
    }

    return $r
}

use Test::More;

is convert(1), 'A', 'A';
is convert(26), 'Z', 'Z';
is convert(27), 'AA', 'AA';
is convert(52), 'AZ', 'AZ';
is convert(53), 'BA', 'BA';
is convert(789), 'ADI', 'ADI';

is convert('A'), 1, 'A';
is convert('Z'), 26, 'Z';
is convert('AA'), 27, 'AA';
is convert('AZ'), 52, 'AZ';
is convert('BA'), 53, 'BA';
is convert('ADI'), 789, 'ADI';

is convert(28), 'AB', 'encode';
is convert('AD'), 30, 'decode';

done_testing();
