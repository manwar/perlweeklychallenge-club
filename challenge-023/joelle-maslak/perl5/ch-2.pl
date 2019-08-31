#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw(first);
use Memoize;

die("Please provide only number to decompose") unless @ARGV == 1;
my $num = shift @ARGV;
die("Number must be an integer") if "$num" ne int($num);

say "$num = " . join( " * ", sort { $a <=> $b } prime_factors($num) );

sub prime_factors($i) {
    if ( $i <= 1 ) { return @{ [$i] }; }

    my $first = first_factor($i);
    return @{ [$i] } unless defined $first;    # It is prime
    return $first, prime_factors( $i / $first );
}

memoize('first_factor');

sub first_factor($i) {
    if ( $i <= 0 ) { return }

    my $sqrt = int( sqrt($i) );

    return first { ( $i % $_ ) == 0 } 2 .. $sqrt;
}

