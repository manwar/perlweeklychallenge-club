use strict;
use warnings;
##
# Write a script to find out first 10 circular primes having at least 3 digits (base 10).
##
use boolean;
use Math::Primality qw/is_prime/;

sub is_circular_prime{
    my($x) = @_;
    my @digits = split(//, $x);
    for my $i (0 .. @digits - 1){
        @digits = (@digits[1 .. @digits - 1], $digits[0]);
        my $candidate = join("", @digits) + 0;
        return false if !is_prime($candidate);
    }
    return true;
}

sub first_n_circular_primes{
    my($n) = @_;
    my $i = 100;
    my %circular;
    my @circular_primes;
    {
        if(is_circular_prime($i) && !$circular{join("", sort {$a <=> $b} split(//, $i))}){
            push @circular_primes, $i; 
            $circular{join("", sort {$a <=> $b} split(//, $i))} = -1;
        }
        $i++;
        redo if @circular_primes < $n;
    }
    return @circular_primes;
}

sub first_10_circular_primes{
    return first_n_circular_primes(10);
}

MAIN:{
    print join(", ", first_10_circular_primes()) . "\n";
}