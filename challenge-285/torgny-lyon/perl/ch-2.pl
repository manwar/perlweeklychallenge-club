#!/usr/bin/perl

use v5.40;

use List::Util qw(first);
use Test::More tests => 3;

my %coins = (
    50 => [ [ 25, 25 ], [ 10, 10, 10, 10, 10 ] ],
    25 => [ [ 10, 10, 5 ] ],
    10 => [ [ 5, 5 ] ],
    5  => [ [ 1, 1, 1, 1, 1 ] ],
    1  => [ [1] ],
);

sub make_change {
    my $n = shift;
    my @l;
    while ($n > 0) {
        my $coin = first { $_ <= $n } sort { $b <=> $a } keys %coins;
        push @l, $coin;
        $n -= $coin;
    }
    return f([@l], {});
}

sub f {
    my @l = sort @{ $_[0] };
    my $h = $_[1];
    return if exists $h->{"@l"};
    $h->{"@l"} = 1;
    foreach my $i (grep { $l[$_] != 1 } 0..$#l) {
        foreach (@{ $coins{ $l[$i] } } ) {
            my @a = @l;
            splice @a, $i, 1, @{$_};
            f([@a], $h);
        }
    }
    return keys %$h;
}

is(make_change(9), 2);
is(make_change(15), 6);
is(make_change(100), 292);
