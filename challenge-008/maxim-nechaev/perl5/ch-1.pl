#!/usr/bin/perl -w
use strict;
use feature 'say';
use List::Util qw/sum/;

my ($i, $p) = (1, 0);
do {
    # candidate for perfect from next $i
    my $n = oct '0b' . 1 x ($i + 1) . 0 x $i;

    # find $n divisors expect 1 and $n
    my @d = map { $n % $_? () : ($_, $n/$_) } 2..sqrt $n;

    # check for perfect
    $p++, say $n if $n == 1 + sum @d;
} while ( $i++, $p<5 );
