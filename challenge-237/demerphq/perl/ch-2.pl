use strict;
use warnings;

# Maximum greatness. Given an array of integers compute
# the maximum number of pairs that satisfy $A[$i] < $A[$j]
# where each possible value of $i and $j is used only once.
# If $permute is passed in then treat it as an array ref
# which is to be populated with the permutation of $array
# that would produce that maximum number of pairs.

sub maximum_greatness {
    my ($array, $permute) = @_;

    # Compute the number of occurrences of each unique value, keeping
    # track of the maximum number of occurrences. If the array was large
    # and the number of duplicates high we might get better performance
    # by doing two loops, first over the array itself, and then over the
    # values in the result. But for arrays with few or no duplicated
    # values this will be faster.

    my %seen;
    my $max = 0;
    $seen{$value}++ for @$array;
    foreach my $value (@$array) {
        my $count = ++$seen{$value};
        $max = $count if $max < $count;
    }

    if ($permute) {
        # they have asked us to compute the permutation
        # as the count, so we have to sort the array.

        # sort the indexes into the original array, not
        # the array itself so we can use it to populate
        # $permute as well as read from $array.
        my @sorted_idx = sort {
                            $array->[$a] <=> $array->[$b] ||
                            $a <=> $b
                        } 0 .. $#$array;

        # now compute the permutation
        for my $i (0 .. $#$array) {
            my $next = ($i + $max) % @$array;
            $permute->[$sorted_idx[$i]] = $array->[$sorted_idx[$next]];
        }
    }

    return @$array - $max;
}


use Test::More;
foreach my $tuple (
    [ 4, [ 1, 3, 5, 2, 1, 3, 1 ],
         [ 2, 1, 1, 5, 3, 1, 3 ] ],
    [ 5, [ 1, 2, 2, 3, 3, 4, 4 ],
         [ 2, 3, 3, 4, 4, 1, 2 ]],
    [ 4, [ 1, 2, 3, 4, 5 ],
         [ 2, 3, 4, 5, 1 ] ],
    [ 3, [  55, 22, -33, 10 ],
         [ -33, 55,  10, 22 ] ],
) {
    my ($want, $array, $want_permute)= @$tuple;
    my $permute = [];
    my $count = maximum_greatness($array, $permute);
    is($count, $want, "Array   [@$array] count should be $want");
    is("@$permute", "@$want_permute", "Permute [@$want_permute]")
        if $permute;
}
done_testing();
