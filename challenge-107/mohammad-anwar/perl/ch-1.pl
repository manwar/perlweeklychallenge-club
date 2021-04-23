#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( top_self_descriptive(3), [ 1210, 2020, 21200 ] );
is( self_descriptive(1210),  1 );
is( self_descriptive(2020),  1 );
is( self_descriptive(21200), 1 );
is( self_descriptive(10000), 0 );

done_testing;

sub top_self_descriptive {
    my ($c) = @_;

    my $n = 1;
    my $i = 0;
    my @d = ();

    while ($i < $c) {
        if (self_descriptive($n)) {
            $i++;
            push @d, $n;
        }
        $n++;
    }

    return \@d;
}

sub self_descriptive {
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
