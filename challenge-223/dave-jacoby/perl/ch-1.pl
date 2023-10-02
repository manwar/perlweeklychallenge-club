#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Getopt::Long;

my $n;
my $v = 0;
GetOptions( 'n=i' => \$n, 'v' => \$v );

my @examples = ( 10, 1, 20 );

if ( defined $n ) {
    count_primes($n);
}
else {
    for my $n (@examples) {
        count_primes($n);
    }
}

sub count_primes( $n ) {
    my @o = grep { is_prime($_) } 2 .. $n;
    my $o = scalar @o;
    say <<~"END";
        INPUT: \$n = $n
        Output: $o
    END
    say join ',', @o if $v;
}

sub is_prime ($n) {
    die "Bad number $n" unless length $n;
    return 0 if $n == 0;
    return 0 if $n == 1;
    for ( 2 .. sqrt $n ) { return 0 unless $n % $_ }
    return 1;
}
