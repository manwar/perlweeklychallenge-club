use strict;
use warnings;
use Const::Fast;

const my $TARGET => 5;

MAIN:
{
    my $count = 0;

    # It is known that if any odd number n is perfect, n > 10^1500; so only even
    # numbers need be considered. By the Euclid-Euler Theorem, an even number n
    # is a perfect number if and only if n = 2^(k-1)*(2^k-1), where 2^k-1 is
    # prime. So the perfect numbers are a subset of the positive integers n of
    # the form n = 2^(k-1)*(2^k-1), where k is a positive integer.

    for (my $k = 1; $count < $TARGET; ++$k)
    {
        my $n = (2 ** ($k - 1)) * (2 ** $k - 1);

        if (is_perfect($n))
        {
            print "$n\n";
            ++$count;
        }
    }
}

# A positive integer n is perfect if and only if n is equal to the sum of its
# positive proper divisors (factors). (Equivalently, n is perfect if and only if
# it is equal to half the sum of its divisors, where the latter include n
# itself).

sub is_perfect
{
    my ($n) = @_;

    return 0 if $n == 1;              # 1 is not a perfect number

    my $max = int(sqrt($n) + 0.5);
    my $sum = 1;                      # Every positive integer has 1 as a factor

    for my $d (2 .. $max)
    {
        $sum += $d + ($n / $d) if ($n % $d) == 0;
    }

    return $n == $sum;
}
