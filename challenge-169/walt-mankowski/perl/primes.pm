package primes;
use Exporter 'import';
our @EXPORT_OK = qw(primes_to prime_factors);

use v5.36;
use builtin 'indexed';
no warnings 'experimental::for_list';
no warnings 'experimental::builtin';

# find the primes up to $n using the sieve of Eratosthenes and return
# them as an arrayref
sub primes_to($n) {
    my @is_prime = map {1} 0..int($n);
    $is_prime[0] = $is_prime[1] = 0;
    for my $i (2..int(sqrt($n))) {
        if ($is_prime[$i]) {
            for (my $j = $i+$i; $j <= $n; $j += $i) {
                $is_prime[$j] = 0;
            }
        }
    }

    my @primes;
    for my ($i, $v) (indexed @is_prime) {
        push @primes, $i if $v;
    }
    return \@primes;
}

# return the prime factors of $n as a sorted list
sub prime_factors($n, $primes) {
    my @factors;
    for my $p ($primes->@*) {
        return @factors if $p > $n;
        while ($n % $p == 0) {
            push @factors, $p;
            $n /= $p;
        }
    }
}

1;
