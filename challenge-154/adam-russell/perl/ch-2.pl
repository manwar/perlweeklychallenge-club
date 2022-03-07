use strict;
use warnings;
##
# Write a script to compute the first 10 distinct Padovan Primes.
##
use Math::Primality qw/is_prime/;

sub first_n_padovan_primes{
    my($n) = @_;
    my @padovan_primes;
    my @padovans = (1, 1, 1);
    {
        push @padovans, $padovans[@padovans - 2] + $padovans[@padovans - 3];
        push @padovan_primes, $padovans[@padovans - 1] if is_prime($padovans[@padovans - 1]);
        redo if @padovan_primes <= $n;
    }
    return @padovan_primes[1..@padovan_primes - 1];
}

MAIN:{
    print join(", ", first_n_padovan_primes(10)) . "\n";
}