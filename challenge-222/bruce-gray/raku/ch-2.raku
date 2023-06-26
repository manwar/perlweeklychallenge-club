sub task2  ( @ns_original --> Int ) {
    my @ns = @ns_original;

    sub remove_max ( --> UInt ) {
        return @ns.splice( @ns.maxpairs[0].key, 1 )[0];
    }

    while @ns >= 2 {
        my $y = remove_max();
        my $x = remove_max();

        push @ns, $y - $x if $x != $y;
    }

    return @ns[0] // 0;
}


# Thanks to Yves "demerphq" Orton for bringing this efficient
# technique to my attention in his comments here:
# https://blogs.perl.org/users/bruce_gray/2023/02/twc-205-exclusive-third-or-first.html
use BinaryHeap;
sub task2_h ( @ns --> Int ) {
    my BinaryHeap::MaxHeap $heap .= new(@ns); # Always pops the maximum value.

    loop {
        my $y = $heap.pop;

        return $y if not $heap;

        my $x = $heap.pop;

        $heap.push($y - $x) if $x != $y;

        return 0 if not $heap;
    }
}


my @tests =
    ( 1, ( 2, 7, 4, 1, 8, 1 ) ),
    ( 1, ( 1,               ) ),
    ( 0, ( 1, 1             ) ),

    ( 2, ( 30, 15, 7, 3, 2, 1    ) ),
    ( 3, ( 30, 15, 7, 3, 2       ) ),
    ( 1, ( 30, 15, 7, 3, 2, 1, 1 ) ),
;
use Test;
plan 2 * @tests;
for @tests -> ( $expected, @in ) {
    is task2(  @in), $expected;
    is task2_h(@in), $expected;
}
