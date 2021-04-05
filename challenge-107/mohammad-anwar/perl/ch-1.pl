#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( top_self_descriptive(3), [ 1210, 2020, 21200 ] );

done_testing;

sub top_self_descriptive {
    my ($c) = @_;

    my $n = 1;
    my $i = 0;
    my @d = ();

    while ($i < $c) {
        if (is_self_descriptive($n)) {
            $i++;
            push @d, $n;
        }
        $n++;
    }

    return \@d;
}

sub is_self_descriptive {
    my ($n) = @_;

    my @n = split //, $n;
    my %m;
    map { $m{$_}++ } @n;

    my $i = 0;
    while ($i < @n) {
        return 0 unless (($m{$i} //= 0) == $n[$i]);
        $i++;
    }

    return 1;
}
