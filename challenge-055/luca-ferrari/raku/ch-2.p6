#!env raku
#
#Wave Array
#
# Any array N of non-unique, unsorted integers can be arranged
# into a wave-like array such that n1 ≥ n2 ≤ n3 ≥ n4 ≤ n5 and so on.
#
# For example, given the array [1, 2, 3, 4],
# possible wave arrays include [2, 1, 4, 3] or [4, 1, 3, 2],
# since 2 ≥ 1 ≤ 4 ≥ 3 and 4 ≥ 1 ≤ 3 ≥ 2. This is not a complete list.
#
# Write a script to print all possible wave arrays
# for an integer array N of arbitrary length.
#  Notes:
#
# When considering N of any length,
# note that the first element is always greater
# than or equal to the second, and then the ≤, ≥, ≤, …
# sequence alternates until the end of the array.


# Test if a single sequence is ok.
# The third argument checks if the test has to be done as >= or <=.
sub is-ok( Int:D $a, Int:D $b, Bool:D $greater ) {
    return $a >= $b if ( $greater );
    return $a <= $b if ( ! $greater );
}


sub MAIN( Int:D $number where { $number.chars > 1 } ){
    my @array = $number.comb;

    say "Waving { @array } of { @array.elems } elements ";
    for @array.permutations -> @current {
        my $ok = False;
        my $test = True; # true = greater
        for 0 ..^ @current.elems - 1 -> $index {
            $ok   = is-ok @current[ $index ].Int, @current[ $index + 1 ].Int, $test;
            $test = ! $test;
            last if ! $ok;
        }

        say "Found wave { @current }" if $ok;
    }
}
