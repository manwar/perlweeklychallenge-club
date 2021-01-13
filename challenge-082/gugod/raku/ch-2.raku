#!/usr/bin/env raku

sub MAIN (Str $A, Str $B, Str $C) {
    say interleaves($A, $B, $C) ?? 1 !! 0;
}

sub interleaves (Str $A, Str $B, Str $C) {
    my @stash;
    @stash.push([-1, -1]);

    my $i = 0;
    while $i < $C.chars && @stash.elems > 0 {
        my $c = $C.substr($i++, 1);
        my @stash2 = gather {
            while @stash.elems > 0 {
                my $it = @stash.pop();
                my $a = $A.substr($it[0]+1, 1);
                my $b = $B.substr($it[1]+1, 1);
                if $c eq $a {
                    take [$it[0]+1, $it[1]];
                }
                if $c eq $b {
                    take [$it[0], $it[1]+1];
                }
            }
        };

        @stash = @stash2.unique(:with(&[eqv]));
    }

    return $i == $C.chars && @stash.elems > 0 && @stash[0][0].succ == $A.chars && @stash[0][1].succ == $B.chars;
}
