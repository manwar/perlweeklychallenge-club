#!/usr/bin/env raku

sub right-interval (+@intervals) {
    my %start is default(-1) = (
        @intervals
        andthen .map: *.head
        andthen .antipairs
    );

    @intervals.map: -> ($, $end) { %start«$end» }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is right-interval([3,4], [2,3], [1,2]),(-1,0,1);
    is right-interval([1,4], [2,3], [3,4]),(-1,2,-1);
    is right-interval(([1,2],)),(-1);
    is right-interval([1,4],[2,2],[3,4]),(-1, 1, -1);
    is right-interval([1,2],[3,4],[5,6], [4,5], [2,3], [6,1]),(4,3,5,2,1,0);
    done-testing;
}

multi MAIN (+intervals) {
    say right-interval intervals.batch(2)
}
