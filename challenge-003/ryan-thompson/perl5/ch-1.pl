#!/usr/bin/env perl
#
# ch-1.pl - Generate 5-smooth numbers (all prime divisors < 5)
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use List::Util qw< min max sum >;

my $limit = $ARGV[0] // die "Usage: $0 <limit>";

say join ', ', hamming($limit);

# Return hamming numbers up to the specified limit.

# We do this by putting all # Hamming numbers < $limit into an array (@n).
# The list is then sorted. This gives us O(n log n) complexity. See POD.
sub hamming {
    my $limit = shift;

    # Pre-generate all powers of prime factors 2, 3, and 5
    my @d2 = map { 2**$_ } 0..( log($limit) / log(2) );
    my @d3 = map { 3**$_ } 0..( log($limit) / log(3) );
    my @d5 = map { 5**$_ } 0..( log($limit) / log(5) );

    my @n;
    for my $d2 (@d2) {
        for my $d3 (@d3) {
            last if $d2 * $d3 > $limit;
            push @n, grep { $_ <= $limit } map { $d2 * $d3 * $_ } @d5;
        }
    }

    sort { $a <=> $b } @n;
}

__END__

=head1 COMPLEXITY ANALYSIS

Perl's mergesort C<sort()> guarantees O(N log N) worst case behaviour. The
final line of our function is:

    sort { $a <=> $b } @n;

So we are certainly bound by O(N log N) complexity on the size of the
resulting list. However, is it possible for another term to dominate?

We do have a 3-level nested loop over C<@d2>, C<@d3> and C<@d5>.
Fortunately, the bounds for each loop are known to be:

    log($limit) / log($prime)   # Where $prime is 2, 3, or 5

Additionally, we exit the loops early when the partial product is already
greater than C<$limit>. Even if we ignore this, the complexity we get
from these loops is:

    (log($limit) / log(2)) * (log($limit) / log(3)) * (log($limit) / log(5))

    LOG_235 = log^3($limit) / (log(2) * log(3) * log(5))

To analytically compare the above (abbreviated to LOG_235) versus N log N, we
need a way to calculate N (i.e., the size of the result list) given the
initial C<$limit>. This is non-trivial. So an easier way to find our answer is
to compare the growth empirically. This works because it is easy to see both
formulae are strictly increasing.

    $limit  List Size (N)  LOG_235    O(N log N)
    --------------------------------------------
      1e1               9       24            19
      1e2              34      105           119
      1e3              86      350           383
      1e4             175      756           903
      1e5             313     1496          1798
      1e6             507     2340          3157
      1e7             768     3960          5102
      1e8            1105     5508          7743
      1e9            1530     7410         11219
      1e10           2053    10710         15658

Thus, except for insignificantly small values of C<$limit>, O(N log N)
dominates, though LOG_235 is never far behind.
