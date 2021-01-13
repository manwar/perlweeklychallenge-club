# kth Permutation Sequence
#
# Write a script to accept two integers n (>=1) and k (>=1). It should print
# the kth permutation of n integers. For more information, please follow the
# wiki page.
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

my $k-per-seq = -> $n, $k { (1..$n).permutations()[$k - 1].join('') };
say $k-per-seq(3, 4);
