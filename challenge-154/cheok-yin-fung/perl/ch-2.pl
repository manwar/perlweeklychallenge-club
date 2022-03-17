#!/usr/bin/perl
# The Weekly Challenge 154
# Task 2 Padovan Prime

use v5.22.0;
use warnings;
use Math::BigInt;

use Math::Prime::Util qw/prime_precalc is_prime/;
prime_precalc(100_000_000);



my $NUM_OF_TERMS = $ARGV[0] || 10;

my @ans = ();
my $pdvstate = [Math::BigInt->new(1), Math::BigInt->new(1),
                Math::BigInt->new(1), Math::BigInt->new(2)];

core();



sub pdv_iter {
    my ($a, $b, $c, $d) = @{$pdvstate};
    ($a, $b, $c, $d) = ($b, $c, $d, $b+$c);
    @$pdvstate = ($a, $b, $c, $d);
    return $c;
}



sub core {
    my $ind = 3;  # the index is set to be consistent with OEIS:A112882
    while (scalar @ans < $NUM_OF_TERMS) {
        my $Pk = pdv_iter();
        if (is_prime($Pk)) {
            say update_ans($Pk);
        }
        $ind++;
    }
}



sub update_ans {
    my $candidate = $_[0];
    push @ans, $candidate if    defined($ans[-1]) 
                             && $candidate != $ans[-1];
    push @ans, $candidate if !defined($ans[-1]);
    return $ans[-1];
}
