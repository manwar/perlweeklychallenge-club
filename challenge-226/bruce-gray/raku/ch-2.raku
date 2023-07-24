sub task2 ( Int @ns --> UInt ) {
    my @n = @ns.grep(* != 0).sort.squish;
    # Below this point, @n stays in sorted order,
    # so removing later zeros and finding .min
    # can always be done efficiently on the .head,
    # instead of scanning the whole array.
    #
    # Further, because we removed duplicates,
    # there will always be exactly one `zero`
    # after the hypered-subtraction.
    # So, we can write `shift @n;`
    # instead of `shift @n while @n and @n.head == 0;`

    my $c = 0;
    while @n {
        @n »-=» @n.head; # Removes minimum from every array element.
        shift @n;
        $c++;
    }
    return $c;
}

# sub task2_first_attempt_had_no_optimization ( Int @ns --> UInt ) {
#     my @n = @ns.grep: * != 0;
#     my $c = 0;
#     while @n {
#         @n »-=» @n.min;
#         @n .= grep: * != 0;
#         $c++;
#     }
#     return $c;
# }

{
# The task allows for subtracting a quantity smaller than the minimum.
# e.g.  3,5,8,13 ; we could choose to subtract 1 or 2 instead of 3.
# However, in every case, the slot that already held the minimum still does,
# so the next step(s) must just use up the min more slowly.
# So, I am satisfied that the `always use .min in its entirety` must always yield the best result.
# If I am correct in that logic, then the looping version could be replaced
# with `@ns.grep(* != 0).unique.elems`, gaining efficiency while killing any clear linkage to the original task.
    sub task2_alt ( Int @ns --> UInt ) {
        return @ns.grep(* != 0).unique.elems;
    }
    for ^100 {
        my Int @in = (0..100).roll(200);
        my $t1 = task2(@in);
        my $t2 = task2_alt(@in);

        die "$t1 $t2 @in[]" if $t1 != $t2;
    }
}



my @tests =
    ( 3, (1, 5, 0, 3, 5) ),
    ( 0, (0,)            ),
    ( 4, (2, 1, 4, 0, 3) ),
;
use Test;
plan +@tests;
for @tests -> ( $expected, @in ) {
    is task2( Array[UInt].new(@in) ), $expected;
}
