#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say signatures state };
no warnings qw{ experimental };

use List::Util qw{ sum sum0 max };
use Getopt::Long;

my $n = 9;
GetOptions( 'n=i' => \$n, );

use JSON;
my $json = JSON->new->space_after->canonical;

my @primes = reverse grep { is_prime($_) } 2 .. $n;
my @output = prime_sum( $n, \@primes );

map { say $json->encode($_) } @output;
say '';
say $json->encode( $output[0] );

sub prime_sum ( $n, $primes, $list = [], $depth = 1 ) {
    my @output;
    my %join;

    my @list = ( [] );

OUTER: while (@list) {
        my $e = shift @list;
        for my $p ( $primes->@* ) {
            my $new->@* = reverse sort $e->@*, $p;
            my $sum = sum $new->@*;
            my $join = join ' ', $new->@*;
            next if $join{$join}++;
            push @list,   $new if $sum < $n;
            push @output, $new if $sum == $n;
            last OUTER if $sum == $n;
        }
    }
    return @output;
}

sub is_prime ( $n ) {
    my @factors = factor($n);
    return scalar @factors == 1 ? 1 : 0;
}

sub factor ( $n ) {
    my @factors;
    for my $i ( 1 .. $n - 1 ) {
        push @factors, $i if $n % $i == 0;
    }
    return @factors;
}
