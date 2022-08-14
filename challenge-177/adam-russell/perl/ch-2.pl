use strict;
use warnings;
no warnings q/recursion/;
##
#  Write a script to generate first 20 Palindromic Prime Cyclops Numbers.
##
use Math::Primality qw/is_prime/;

sub n_cyclops_prime_r{
    my($i, $n, $cyclops_primes) = @_;
    return @{$cyclops_primes} if @{$cyclops_primes} == $n;
    push @{$cyclops_primes}, $i if is_prime($i) && 
                                   length($i) % 2 == 1 &&
                                   join("", reverse(split(//, $i))) == $i &&
                                   (grep {$_ == 0} split(//, $i))   == 1 && 
                                   do{my @a = split(//, $i);
                                      $a[int(@a / 2)]
                                   } == 0;
    n_cyclops_prime_r(++$i, $n, $cyclops_primes);
}

sub n_cyclops_primes{
    my($n) = @_;
    return n_cyclops_prime_r(1, $n, []);
}

MAIN:{
    print join(", ", n_cyclops_primes(20)) . "\n";
}