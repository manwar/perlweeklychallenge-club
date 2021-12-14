#!/usr/bin/env perl
use strict;
use warnings;
use feature qw'say signatures';
no warnings qw'experimental::signatures';

use List::Util qw'first';

use constant DEBUG => $ENV{DEBUG} // 0;

run() unless caller();

sub run() {
    my $stealthy = stealthy( $ARGV[0] );
    say $stealthy ? 1 : 0;
    explain($stealthy) if DEBUG;
}

sub stealthy($n) {
    my @divisors = find_divisors_pairs($n);
    my @pairs    = pairs(@divisors);

    my $stealthy = first {
        my ( $a, $b, $c, $d ) = flatten($_);
        $a * $b == $c * $d && $a + $b == $c + $d + 1;
    }
    @pairs;

    return $stealthy;
}

sub explain($stealthy) {
    say "Not stealthy" && return if !$stealthy;
    my ( $a, $b, $c, $d ) = flatten($stealthy);
    say
"Since $a (a) * $b (b) = $c (c) * $d (d) and $a (a) + $b (b) = $c (c) + $d (d) + 1";
}

sub pairs(@xs) {
    my @out;
    for my $i ( 0 .. $#xs - 1 ) {
        push @out, map { [ $xs[$i], $xs[$_] ] } ( $i + 1 .. $#xs );
    }
    return @out;
}

sub flatten($xs) {
    map { @$_ } @$xs;
}

sub find_divisors_pairs($x) {
    my @out;
    my $max = sqrt($x);
    for my $i ( 1 .. $max ) {
        if ( $x % $i == 0 ) {
            push @out, [ $i, $x / $i ];
        }
    }

    return @out;
}
