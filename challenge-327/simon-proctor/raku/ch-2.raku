#!/usr/bin/env raku

#|(Given a list of integers return
a list of pairs which share the minimum absolute
difference found in the list)
sub MAIN (
    *@a where @a.all ~~ Int && @a.unique.elems == @a.elems # A list of distinct integers
) {
    my @ret = [];
    my $mad = Inf;
    for @a.sort.rotor(2 => -1) -> $pair {
        my $diff = $pair[1] - $pair[0];
        if ( $diff < $mad ) {
            @ret = [];
            $mad = $diff;
        }
        if ( $diff == $mad ) {
            @ret.push($pair);
        }
    }
    @ret.say;
}
