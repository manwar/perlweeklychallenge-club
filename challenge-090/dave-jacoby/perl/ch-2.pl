#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use Scalar::Util qw{looks_like_number};

my ( $m, $n ) = map { abs $_ } grep { looks_like_number $_ } @ARGV;

$m //= 17;
$n //= 38;

say <<"END";

    m $m
    n $n
END

say egyptian( $m, $n );
say $m * $n;

exit;

sub egyptian ( $m, $n ) {
    my $o = 0;
    my $i = 1;
    do {
        my $e = $m % 2 != 0 ? 1 : 0;
        say join "\t", $o, $e, $i, $m, $n;
        $o += $n if $e;
        $i *= 2;
        $m = int $m / 2;
        $n = $n * 2;
    } while ( $m > 0 );
    return $o;
}
