#!/usr/bin/perl
use warnings;
use strict;

sub rotate {
    my ($word) = @_;
    my $length = length $word;
    my $original = $word;
    my $i = 0;
    do {
        $word .= substr $word, 0, ++$i % $length, "";
        # print "$i: $word\n";
    } until $word eq $original;
    return $i
}

use Test::More;

is rotate('xyxx'), 7;

done_testing();
