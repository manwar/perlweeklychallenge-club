#!perl6
# Task 1 Challenge 054 Solution by kevincolyer
# kth Permutation Sequence
# Write a script to accept two integers n (>=1) and k (>=1). 
# It should print the kth permutation of n integers. For more information, 
# please follow the wiki page.
# For example, n=3 and k=4, the possible permutation sequences are 
# listed below:
# 123 132 213 231 312 321 
# The script should print the 4th permutation 
# sequence 231.

subset PosInt of Int where * > 0;

#| Permutation sequence 1..n kth item
sub MAIN(PosInt :$n=3, PosInt :$k=4) {
    # make a list with a range of numbers from 1 to $n and take the permutations
    my @p=(1..$n).permutations;
    die "k is too high ($k) - only {@p.elems} in sequence" if $k > @p.elems;
    
    say "n=$n, k=$k => " ~ @p[$k-1].join;
}
