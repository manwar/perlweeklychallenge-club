use strict;
use warnings;

sub is_prime {
    my ($n) = @_;
    return 0 if $n < 2;
    for my $i ( 2 .. sqrt $n ) {
        return 0 if $n % $i == 0;
    }
    return 1;
}

sub generate_semiprimes {
    my ($n) = @_;
    my @primes = grep { is_prime($_) } ( 2 .. $n );
    my %semiprimes;

    for my $i ( 0 .. $#primes ) {
        for my $j ( $i .. $#primes ) {
            my $semiprime = $primes[$i] * $primes[$j];
            $semiprimes{$semiprime} = 1 if $semiprime <= $n;
        }
    }
    return sort { $a <=> $b } keys %semiprimes;
}

print join ", ", generate_semiprimes(100);
