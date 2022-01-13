use strict;
use warnings;
use feature "say";
use constant MAX => 10_001;

sub primes {
    my $max = shift;
    my @primes = (2, 3, 5);
    my $count = 3;
    my $candidate = $primes[-1];
    while ($count <= $max) {
        $candidate += 2;
        my $not_prime = 0;
        my $sq_cand = sqrt $candidate;
        for my $i (@primes) {
            $not_prime = 1, last unless $candidate % $i;
            last if $i > $sq_cand;
        }
        next if $not_prime;
        push @primes, $candidate;
        $count ++;
    }
    return $primes[$max-1];
}
my $p = primes(MAX);
say "$p";
