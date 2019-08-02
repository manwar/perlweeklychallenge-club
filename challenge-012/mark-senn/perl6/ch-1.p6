# Perl Weekly Challenge - 012
# Challenge #1
#
# See
#     engineering.purdue.edu/~mark/pwc-012.pdf
# for more information.

# Run using Perl 6.
use v6;

# Get prime numbers from 2 to 1,000.
# This doesn't read left-to-right
#     my @prime = grep &is-prime, (2..1_000);
# as well as this does:
my @prime = (2..1_000).grep(&is-prime);

for (^@prime.elems) -> $i
{
    # This could be optimized by keeping a running product of the
    # first n primes and then just multiplying by the (n+1)st prime
    # but
    #     Premature optimization is the root of all evil.
    #     ---Donald Ervin Knuth
    my $e = ([*] @prime[0..$i]) + 1;
    ($e.is-prime)  or  $e.say,  last;
}
