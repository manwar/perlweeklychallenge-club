#!env rau

# Perl Weekly Challenge 54
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/>
#
# Task 1
#
# kth Permutation Sequence
# 
# Write a script to accept two integers n (>=1)
# and k (>=1). It should print the kth permutation of n integers.
# For more information, please follow the wiki page.
# 
# For example, n=3 and k=4, the possible permutation sequences are listed below:
#
# 123
# 132
# 213
# 231
# 312
# 321
# 
# The script should print the 4th permutation sequence 231.


sub MAIN( Int:D :$n where { $n >= 1 },
        Int:D :$k where { $k >= 1 } ) {

    "Computing the {$k}-th permutation of $n".say;

    # get all the single digits
    # that can be permutated
    my @digits;
    for 1 .. $n {
        @digits.push: $_;
    }


    my @permutations = @digits.permutations.sort;
    say "does not exist" if ( $k >= @permutations.elems );
    say @permutations[ $k - 1 ];
}
