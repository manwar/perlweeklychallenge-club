use v6.d;

#
#       waves.raku
#
#         55 - TASK #2
#         Wave Array
#             Any array N of non-unique, unsorted integers can be arranged into
#             a wave-like array such that n1 ≥ n2 ≤ n3 ≥ n4 ≤ n5 and so on.
#
#             For example, given the array [1, 2, 3, 4], possible wave arrays
#             include [2, 1, 4, 3] or [4, 1, 3, 2], since 2 ≥ 1 ≤ 4 ≥ 3 and 4 ≥
#             1 ≤ 3 ≥ 2. This is not a complete list.
#
#             Write a script to print all possible wave arrays for an integer
#             array N of arbitrary length.
#
#             Notes: When considering N of any length, note that the first
#             element is always greater than or equal to the second, and then
#             the ≤, ≥, ≤, … sequence alternates until the end of the array.
#
#         method: A wave sequence can be considered a special case of
#             permutation, with the valid arrangements restricted by the greater
#             than / less than cycle. As such it makes sense to proceed like a
#             permutation generator, with the addition that we immediately throw
#             out cases as they are formed when the next digit cannot fit the
#             requirements.
#
#             The recursive function
#
#                 wave_at_yourself(\@set, \@working, $waves, $direction)
#
#             takes a set of remaining possible list values, a working list
#             under construction, an array holding references to completed wave
#             sequences and a direction flag that toggles every recursion.
#
#             With each instantation we toggle the direction, refer to the last
#             number placed on the working array and construct a subset of
#             values either less than or greater than (or equal to) the previous
#             value, as directed. For each of the possible next values in the
#             subset, new sets are made moving the value from the possible
#             values set to the working set and the function is called again
#             using these. If at any time the subset has no values but we are
#             not finished we have reached a contradiction and we return empty
#             handed. If both the larger set and the subset each only have one
#             value we have succesfully allocated our elements accoring to the
#             rules and have completed a wave.
#
#             Between iterating over only the values greater or less than the
#             previous and pruning the tree early when we cannot continue, the
#             search space looking for valid solutions is greatly reduced as
#             compared to a simple permutation recursion.
#
#             In raku it might be tempting to use the .permutations routine,
#             check and filter the results for valid sequences. However this
#             method will require computing every single permutation first,
#             which for longer sequences will become increasingly
#             computationally intensive. So we won't do that today. YMMV.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (*@input) {

    my @set = @input.elems < 2 ?? 1..@input[0] !! @input.sort({ $^a <=> $^b });

    my @working;
    my @waves;
    my $direction = 0;

    wave_at_yourself( @set, @working, @waves, $direction);

    .join(', ').say for @waves;
}


sub wave_at_yourself ( @prev_set, @prev_working, @waves, $direction is copy){
## Given a starting set, a working list, a waves set and a direction,
## computes complete waves as arrays and places the arrays on the waves array
## direction:  0 => down, 1 => up

    ## Toggle direction every recursion
    $direction +^= 1;

    ## Create a new copy of the previous set
    my @set    = @prev_set;

    ## The subset is those elements that are either ≥ or ≤ the previous element as selected.
    ## If the subset size is 0 we cannot continue and bail without adding to the waves array.
    ## Not sure where I stand on using the non-ascii glyph options for overall readability.
    my $prev   = @prev_working.tail;
    my @subset = $prev.defined ?? @set.grep({ $direction ?? $_ ≥ $prev !! $_ ≤ $prev }) !! @set;
    return if @subset.elems == 0;

    ## If there is only one element left in both the set and the subset,
    ## then we have successfully made a wave.
    ## We add it to the working list,
    ## push that array onto the waves array and return.
    ## This unique wave is complete.
    if ( @set.elems == 1 && @subset.elems == 1 ) {
        my @working = @prev_working;
        @working.append: @set;
        @waves.push: @working;
        return;
    }

    ## Iterate through the remaining elements of the set, for each creating new copy of
    ## the working list, moving the selected element from the current set to the working list
    ## and recursing with these new lists.
    for @subset -> $element {
        my @working = @prev_working;
        @working.push: $element;
        my @set_minus_one = @set.grep: { $_ != $element };
        wave_at_yourself( @set_minus_one, @working, @waves, $direction );
    }
}
