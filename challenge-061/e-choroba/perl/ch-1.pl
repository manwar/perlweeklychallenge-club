#! /usr/bin/perl
use warnings;
use strict;

# use List::Util qw{ product };

sub product {
    my @list = @_;
    my $p = 1;
    $p *= $_ for @list;
    return $p
}

sub max_prod {
    my ($list) = @_;
    my $max = [$list->[0]];
    for my $i (0 .. $#$list) {
        for my $j ($i .. $#$list) {
            my $p = product(@$list[$i .. $j]);
            $max = [$p, @$list[$i .. $j]] if $p > $max->[0];
        }
    }
    return $max
}

use Test::More tests => 1;
is_deeply max_prod([2, 5, -1, 3]), [10, 2, 5];
