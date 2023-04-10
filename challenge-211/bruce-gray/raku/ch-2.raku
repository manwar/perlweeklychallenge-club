# The average of a solution group will == the average of the whole array.
# The average of a solution group is .sum/.elems,
# and .elems is fixed during each loop of $group_size,
# so we can pre-calculate the sum to search for.
# A further optimization comes from the task specifying that all elements are integers.
# Their sum must be an integer, so if the "target sum" is not an integer, we can skip the whole group of that size.
# e.g. 1..8 has an average of 9/2; a group of size 3 can never average to 9/2, because the divisor will be 3.
sub task2 ( @ns where { @ns.all ~~ Int } --> Bool ) {
    my Rat $average = @ns.sum / @ns.elems;

    for 1 .. (@ns.elems div 2) -> $group_size {

        my Rat $target_sum = $average * $group_size;

        next unless $target_sum.denominator == 1;

        return True if @ns.combinations($group_size)».sum.any == $target_sum;
    }

    return False;
}

# This was my first solution.
# Averages are Rats, so `==` need not worry about precision.
# No need to create the second group, since its .sum and its .elems
# can be calculated as the difference from the first group.
sub task2_original ( @ns --> Bool ) {
    my $all_sum   = @ns.sum;
    my $all_elems = @ns.elems;

    for 1 .. (@ns.elems div 2) -> $group_size {
        for @ns.combinations($group_size) {
            my $sum   = .sum;
            my $elems = .elems;

            my $average_A = $sum / $elems;
            my $average_B = ($all_sum - $sum) / ($all_elems - $elems);
            return True if $average_A == $average_B;
        }
    }

    return False;
}


my @tests =
    ( ( 1, 2, 3, 4, 5, 6, 7, 8 ), True  ),
    ( ( 1, 3                   ), False ),

    ( ( 1, 3, 1, 3             ), True  ),
    ( ( 8, 7, 9                ), True  ),
    ( ( 8, 7, 8                ), False ),
;
use Test;
plan +@tests;
for @tests -> ( $in, $expected ) {
    is task2($in), $expected;
}
