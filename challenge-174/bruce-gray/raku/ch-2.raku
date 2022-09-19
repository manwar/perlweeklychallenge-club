# Works with non-Ints, too.
sub permutation2rank ( @a          ) { @a.sort.permutations.first: :k, * eqv @a.List }
sub rank2permutation ( @a, UInt $n ) { @a.sort.permutations[$n] }

# I did not read "The rank of a permutation" and "Segment tree" until I had completed this task.
#   https://tryalgo.org/en/permutations/2016/09/05/permutation-rank/
#   https://tryalgo.org/en/data%20structures/2016/06/25/segment-tree/
# Otherwise, I would have been interested in implementing the O(n log n) algorithm,
# to compare against the performance of Raku's built-in permutations().

multi sub MAIN ( UInt $n, *@a ) { say rank2permutation( @a, $n ) }
multi sub MAIN (          *@a ) { say permutation2rank( @a     ) }
multi sub MAIN ( 'test'       ) {
    use Test;
    plan 9;

    is permutation2rank( <1 0 2>    ), 2;
    is rank2permutation( <0 1 2>, 0 ), <0 1 2>;
    is rank2permutation( <0 1 2>, 1 ), <0 2 1>;
    is rank2permutation( <0 1 2>, 2 ), <1 0 2>;
    is rank2permutation( <0 1 2>, 3 ), <1 2 0>;
    is rank2permutation( <0 1 2>, 4 ), <2 0 1>;
    is rank2permutation( <0 1 2>, 5 ), <2 1 0>;

    is permutation2rank( <Cinderella Dumbo Ariel      Bambi>     ), 16;
    is rank2permutation( <Ariel      Bambi Cinderella Dumbo>, 16 ),
                         <Cinderella Dumbo Ariel      Bambi>;
}
