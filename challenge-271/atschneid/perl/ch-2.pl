# You are give an array of integers, @ints.A

# Write a script to sort the integers in ascending order by the number of 1 bits in their binary representation. In case more than one integers have the same number of 1 bits then sort them in ascending order.

# Example 1
# Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
# Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

# 0 = 0 one bits
# 1 = 1 one bits
# 2 = 1 one bits
# 4 = 1 one bits
# 8 = 1 one bits
# 3 = 2 one bits
# 5 = 2 one bits
# 6 = 2 one bits
# 7 = 3 one bits
# Example 2
# Input: @ints = (1024, 512, 256, 128, 64)
# Output: (64, 128, 256, 512, 1024)

# All integers in the given array have one 1-bits, so just sort them in ascending order.

use strict;
use warnings;

use v5.38;

use List::Util qw( reduce );

my @examples = (
     [0, 1, 2, 3, 4, 5, 6, 7, 8],
     [1024, 512, 256, 128, 64]
    );

for (@examples) {
    say "***||***";
    my @derefed_array = @$_;
    say "input: " . join ", ", @derefed_array;
    my @sorted_array = sort_binary_ones( @derefed_array );
    say "output: " . join ", ", @sorted_array;
}

sub sort_binary_ones ( @input ) {
    # convert each integer to a binary string
    my @bins = map { sprintf "%b", $_ } @input;
    # sum up the value of each binary string
    my @bin_sums = map { reduce { $a + $b } 0, split(//, $_) } @bins;

    # make a list of tuples of type ( binary sum, integer value )
    my @tuple_list = ();
    for (0..scalar(@bin_sums) - 1) {
	push @tuple_list, ([ $bin_sums[$_], $input[$_]]);
    }

    # sort tuple list, first on binary sum, then on integer value
    my @sorted_list = sort { ${$a}[0] <=> ${$b}[0] || ${$a}[1] <=> ${$b}[1] } @tuple_list;

    # return a list of the integer values from the sorted list
    return map { ${$_}[1] } @sorted_list;
}

