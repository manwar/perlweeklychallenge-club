use strict;
use warnings;
no warnings q/recursion/;
##
# Calculate the first 13 Perrin Primes.
##
use boolean;
use Math::Primality qw/is_prime/;

sub n_perrin_prime_r{
    my($n, $perrins, $perrin_primes) = @_;
    return $perrin_primes if keys %{$perrin_primes} == $n;
    my $perrin = $perrins->[@{$perrins} - 3] + $perrins->[@{$perrins} - 2];
    push @{$perrins}, $perrin;
    $perrin_primes->{$perrin} = -1 if is_prime($perrin);
    n_perrin_prime_r($n, $perrins, $perrin_primes);
}

sub perrin_primes{
    return n_perrin_prime_r(13, [3, 0, 2], {});
}

MAIN:{
    print join(", ", sort {$a <=> $b} keys %{perrin_primes()}) . "\n";
}