#!/usr/bin/perl
use 5.038;
use builtin qw/ false /;
use warnings;
no warnings qw/ experimental::builtin /;

sub isMountain(@ints) {
    if (@ints < 3) {
        return false;
    }

    my $i = 0;

    while ($i < $#ints && $ints[$i] < $ints[$i + 1]) {
        $i++;
    }

    if ($i == 0 || $i == $#ints) {
        return false;
    }

    while ($i < $#ints && $ints[$i] > $ints[$i + 1]) {
        $i++;
    }

    return $i == $#ints;
}

say isMountain(@ARGV) ? 'true' : 'false';