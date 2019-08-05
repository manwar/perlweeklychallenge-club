#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

die("Usage: $0 <number of sequence elements>") unless @ARGV <= 1;
my $length = $ARGV[0] // 10;

sub MAIN() {
    my @strong;
    my @weak;

    my $pos = 1;
    while (@strong < $length) {
        if (prime($pos) > (prime($pos-1) + prime($pos+1)) / 2) {
            push @strong, prime($pos);
        }
        $pos++;
    }

    $pos = 1;
    while (@weak < $length) {
        if (prime($pos) < (prime($pos-1) + prime($pos+1)) / 2) {
            push @weak, prime($pos);
        }
        $pos++;
    }

    say "Strong: " . join(",", @strong);
    say "Weak:   " . join(",", @weak);
}

MAIN();

sub prime($i) {
    state @primes = (2, 3);

    prime($i-1) if $i > scalar(@primes);
    return $primes[$i] if $i < scalar(@primes);

    my $last = $primes[-1];
    do { $last += 2 } until perl_isprime($last);

    push @primes, $last;
    return $last;
}

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
