# Write a script to print all possible series of 3 positive numbers, where in
# each series at least one of the number is even and sum of the three numbers
# is always 12. For example, 3,4,5.

# This should not be too hard. First notice that if (i, j, k) is a triple that
# sums up to 12, we have symetric tuples (i, k, j), (j, i, k), (j, k, i),
# (k, i, j), and (k, j, i) that also sum up to 12. We make use of this
# symmetry property. Next, if i and j are given in tuple (i, j, k), then we
# know that k = 12 - i - j. So we don't have to loop over k. Last, one of the
# integers needs to be even. Due to symmetry arguments we can always take i to
# be even.

my $total = 12;
my @triplets = [];
for 2, 4 ... $total -> $i {
    for 1 .. ($total - $i - 1) -> $j {
        @triplets = [|(@triplets), |([$i, $j, $total - $i - $j].permutations)];
    }
}

# Because we use permutations we have duplicates. Ex. (10, 1, 1) with j <-> k
# gives (10, 1, 1).
say @triplets.unique;
