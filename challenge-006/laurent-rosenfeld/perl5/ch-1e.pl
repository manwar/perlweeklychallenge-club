e strict;
use warnings;
use feature 'say';
use constant largest_num => 100_000;

sub find_primes {
    my $num = 5;
    my @primes = (2, 3, 5);
    while (1) {
        $num += 2;     # check only odd numbers
        last if $num > largest_num;
        my $limit = int $num ** 0.5;
        my $num_is_prime = 1;
        for my $prime (@primes) {
            last if $prime > $limit;
            if ($num % $prime == 0) {
                $num_is_prime = 0;
                last;
            }
        }
        push @primes, $num if $num_is_prime;
    }
    return @primes;
}
my @prime_numbers = find_primes;
my @primes_for_rama = grep { $_ % 4 == 3 } @prime_numbers;

my $product = 1;
for my $p (@primes_for_rama) {
    my $term = (1 - (1 / $p**2)) **(-1/2);
    $product *= $term;
}
say $product / 2**(1/2);
