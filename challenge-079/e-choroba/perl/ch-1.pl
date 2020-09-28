#!/usr/bin/perl
use warnings;
use strict;

sub count_set_bits {
    my ($n) = @_;
    my ($nearest_power2) = int(log($n) / log(2));
    my $s = ($nearest_power2 * 2 ** ($nearest_power2 - 1) + 1);
    my $rest = $n - 2 ** $nearest_power2;
    $s += $rest + count_set_bits($rest) if $rest > 0;
    return int($s % 1000000007)
}

use Test::More;

is count_set_bits(4), 5, 'Example 1';
is count_set_bits(3), 4, 'Example 2';
is count_set_bits(1000), 4938, 'Thousand';
is count_set_bits(10_000), 64613, 'Ten thousand';
is count_set_bits(2 ** 26 - 1), 872415232, 'Two to 26';
is count_set_bits(2 ** 30), 106127249, 'Modulo hit';
is count_set_bits(2 ** 32 - 1), 719476260, 'Max 32bit';
is count_set_bits(2 ** 32), 719476261, 'Max 32bit + 1';

# For 2 ** 48 and 2 ** 48 - 1, it returns the same numbers :-(
is count_set_bits(2 ** 47 - 1), 953198898, 'Max correct - 1';
is count_set_bits(2 ** 47), 953198899, 'Max correct';

done_testing();

__END__

Explanation:
e.g. N=11

0001
0010
0011
0100
0101
0110
0111
1000
1001
1010
1011

The nearset lower power of 2 is 8 = 2 ** 3. We can ignore the leading
zeros in the first 7 lines, and add the 3 zeros from the eight line.
We get all the possible binary numbers 0 .. 7, there are 12 zeros and
12 ones, which is 3 * 2 ** (3 - 1):

.001
.010
.011
.100
.101
.110
.111
.000

We can now add the leading 1 from the last line.

The remaining numbers all start with a 1. We count the ones (3 here),
remove them, and count the ones in the remaining lines by recursion:

.001
.010
.011
