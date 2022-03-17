use strict;
use warnings;
use feature "say";
use constant MAX => 1000; # MAX must be an even number

my @primes = prime_list(MAX);
my %fortunates = map { find_fortunate($_) => 1} 1..15;
my @result = sort { $a <=> $b } keys %fortunates;
say join " ", @result[0..7];

sub is_prime {
        my $num = shift;
        return 1 if $num == 2;
        return 0 unless $num % 2;
        my $test = 3;
        while ($test < $num/2) {
                return 0 if $num % $test == 0;
                $test += 2;
        }
        return 1;
}

sub prime_list {
    my $max = shift;
    my @prime_list = (2, 3, 5);
    for my $c (7..$max) {
        push @prime_list, $c if is_prime($c);
    }
    return @prime_list;
}


sub find_fortunate {
    my $n = shift;
    my $pn = 1;
    $pn *= $_ for @primes[0..$n-1];
    # say $pn;
    for my $m (2..50) {
        return $m if is_prime($pn + $m);
    }
}
