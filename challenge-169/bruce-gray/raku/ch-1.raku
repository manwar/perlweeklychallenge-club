# I often solve these kinds of tasks by implementing a is-FOO boolean function,
# but this sequence lends itself better to generation by length-of-prime
# when large ranges are needed. To calculate the OEIS b-file (10537 entries),
# this method had 100x the performance of a
# (2..Inf).grep(&some-simple-is-brilliant-function) solution,
# where that function requires factoring-to-primes.
#
# However, this enormous performance difference was 
# due to the b-file ending at the end of three-digit source primes.
# If I compare times to compute the whole b-file plus one extra entry,
# the perfomance falls to 4x the boolean solution.
# I expect this pattern to recur; the more contiguous 4-brilliant numbers
# are requested, the better the relative performance, only to have that
# relative performance drop again as we include the first 5-brilliant number.

# https://oeis.org/A078972  Brilliant numbers
constant @brilliant_numbers = gather for 1 .. Inf -> $length {
    my @primes = grep &is-prime, (10 ** ($length-1))
                             ..^ (10 **  $length   );
    .take for (@primes X* @primes).sort.squish;
}

use Test;
is-deeply @brilliant_numbers.head(20), (4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299).Seq;
is @brilliant_numbers[10537 - 1], 994009;

# The line below produces md5-exact match for https://oeis.org/A078972/b078972.txt , in less than 1 second.
# say .key + 1, ' ', .value for @brilliant_numbers.head(10537).pairs; say '' for ^7;
