#!/usr/bin/perl
use v5.38;
use builtin qw/ true false /;
no warnings 'experimental::builtin';

sub backtrack($int, $pos) {
    state @used = false x ($int + 1);
    my $count = 0;

    if ($pos > $int) {
        return 1;
    }

    for my $i (1 .. $int) {
        if (!$used[$i] && ($i % $pos == 0 || $pos % $i == 0)) {
            $used[$i] = true;
            $count += backtrack($int, $pos + 1);
            $used[$i] = false;
        }
    }

    return $count;
}

my $int = shift;
say backtrack($int, 1);
