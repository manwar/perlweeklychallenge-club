#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;

# TASK #1 › Additive Primes to 100
# An additive prime is a prime number whose decimal digits
# sum to a prime.

my $expected = "2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89";

my  @prime = 2, 3, { first * %% none(@_), (@_[*-1], *+2 … ∞) } … ∞;

sub _is-additive( Any $n --> Bool ) {
    return True if ( [+] $n.Str.split( '' ) ).is-prime;
    False;
}

my @result;

for @prime -> $ap {
    last if $ap > 100;
    @result.push( $ap) if $ap.&_is-additive;
}
my $out = @result.join( ', ');

die 'Logic error.' if $out ne $expected;

say $out;
