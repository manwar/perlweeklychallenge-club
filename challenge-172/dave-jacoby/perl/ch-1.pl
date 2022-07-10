#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Getopt::Long;

my $m = 18;
my $n = 2;

GetOptions(
    'm=i' => \$m,
    'n=i' => \$n,
);

my $done;
prime_partitions( $m, $n );

exit;

sub prime_partitions ( $m, $n ) {
    say <<"END";
M: $m 
N: $n
END
    _prime_partitions( $m, $n );
    say '';
}

sub _prime_partitions ( $m, $n, $baggage = [] ) {
    if ( $n <= 1 ) {
        if ( is_prime($m) && 0 == grep { /$m/ } $baggage->@* ) {
            my $bag = join ' ', sort { $a <=> $b } $baggage->@*, $m;
            return if $done->{$bag}++;
            say qq{ $bag };
            return;
        }
    }
    else {
        for my $i ( 1 .. $m - 1 ) {
            next if !is_prime($i);
            next if grep { /$i/ } $baggage->@*;
            _prime_partitions( $m - $i, $n - 1, [ sort $baggage->@*, $i ] );
        }
    }
}

sub is_prime ($n) {
    die "Bad number $n" unless length $n;
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}
