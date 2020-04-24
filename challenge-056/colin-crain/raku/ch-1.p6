use v6.d;

#
#       56-1-diffickult.raku
#
#       PWC 56 - TASK #1
#         Diff-K
#             You are given an array @N of positive integers (sorted) and
#             another non negative integer k.
#
#             Write a script to find if there exists 2 indices i and j such that
#             A[i] - A[j] = k and i != j.
#
#             It should print the pairs of indices, if any such pairs exist.
#
#             Example:
#
#                 @N = (2, 7, 9)
#                 $k = 2
#             Output : 2,1
#
#         method:
#             Given that
#                 ∀ n:
#                     A[n] > 0
#                     A[n+1] >= A[n]
#                 k >= 0
#
#             And the required truths
#
#                 A[i] - A[j] = k
#                 i != j
#
#             To be true, A[i] > k
#                         A[j] <= A[i]
#
#             which allows us to limit the search space somewhat for a brute
#             force attack on the problem. In fact, because A[j] = A[i] - k, we
#             only need to iterate over the possible i range and then can use a
#             hash lookup for the second part of the search. Note that we can't
#             outright assume that j < i because there exists the case where
#             A[j] = A[i] and j > i. In general, because we allow duplicate
#             values, there can exist multiple j solutions for a given i; we use
#             use a cascading grep filter to produce an array of results for
#             each i in the loop.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (Int:D $k = 24, *@N) {

    my @input = @N.elems > 0 ?? @N !! (^20).map({ (1..50).pick }).sort({ $^a <=> $^b });
    my @indices = (^@input.elems);
    my @output;

    my @is = @indices.grep({ @input[$_] > $k });

    ## for each $i we can do a lookup and see whether any values $input[$j] = $input[$i] - $k exist
    for @is -> $i {
        my @js = @indices.grep({    @input[$_] <= @input[$i]           ## A[j] <= A[i]
                                 && @input[$_] == @input[$i] - $k });  ## A[i] - A[j] = k
                                 &&         $_ != $i                   ## i != j
        for @js -> $j { @output.push: [ $i, $j ] }
    }

    ## output report section
    say "input\n-----\n";
    say ' array: ' ~ @input.join: ', ',;

    say "target: $k";
    say '';

    say "solutions\n---------\n";

    my $format = "i = %2d, j = %-2d --> %2d - %-2d = %d\n";
    printf $format, $_[0], $_[1], @input[$_[0]], @input[$_[1]], $k for @output;
}
