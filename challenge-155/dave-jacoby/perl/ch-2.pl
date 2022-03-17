#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say postderef signatures state };
no warnings qw{ experimental };

OUTER: for my $j ( 2 .. 10 ) {
    my @mod;
    my $fib = fibo_factory();
    for my $i ( 1 .. 60 ) {
        my $f = $fib->();
        my $m = $f % $j;
        push @mod, $m;
        my $mod = join '', @mod;
        do {
            my $sub = $1;
            say join "\t", ' ', $j, ( length $sub ), $sub;
            next OUTER;
            }
            if $mod =~ /
            ^           # start of string being matched
            (\d{3,})    # a digit of three or more characters
                        # (to avoid matching 1,1 at the beginning
                        # of every fibonacci series)
            \1+         # the previous match, repeated once or more
            $           # end of string being matched
            /mx;
    }
}

# creates an anonymous function that's an iterator, returning the next
# fibonacci value each time it's called.
sub fibo_factory ( ) {
    return sub {
        state $calls = 0;
        state @fibonacci;
        $fibonacci[0] = 1 unless $fibonacci[0];
        $fibonacci[1] = 1 unless $fibonacci[1];
        $calls++;
        return 1 if $calls < 3;
        push @fibonacci, $fibonacci[-1] + $fibonacci[-2];
        return $fibonacci[-1];
    }
}

# abigail's prime regex, insspiration for my repeats test
sub is_prime ($n) {
    return ( 1 x $n ) !~ /^1?$|^(11+?)\1+$/ ? 1 : 0;
}
