#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

# Well, let's optimize for speed.  But not force the user to use Inline
# if they can't use it for some reason. So we need a fallback to a pure
# Perl implementation.
#
# This is a trivial enough problem we don't need to optimize for speed,
# but let's do so anyhow.
#
# This line will use lib/Prime.pm if it can be required (it'll require
# Inline::C to compile the C code), but if that fails, we'll fall back
# to the perl_isprime function.
#
# And, yes, it's actually slower running the "fast" int_isprime method
# because of the overhead to load it, but if we had to look at lots of
# primes, it would be faster.  ;)
#
use FindBin;
use lib "$FindBin::Bin/lib";
my $is_prime = eval { require Prime } ? \&Prime::int_isprime : \&perl_isprime;

# The meat of the program -
while (1) {
    state $i       = 1;
    state $product = 1;

    $i++;

    next unless $is_prime->($i);
    $product *= $i;

    if ( !$is_prime->( $product + 1 ) ) {
        say $product+ 1;
        last;
    }
}

# Slow is_prime function, used if we can't load the lib/Prime.pm module.
sub perl_isprime($i) {
    my $sqrt = int( sqrt($i) );

    if ( $i <= 2 )     { return 1; }    # negatives are wrong, at least for us
    if ( $i % 2 == 0 ) { return 0; }

    my $div = 3;
    while ( $div <= $sqrt ) {
        if ( $i % $div == 0 ) { return 0; }

        $div += 2;                      # Test just evens
    }

    return 1;
}
