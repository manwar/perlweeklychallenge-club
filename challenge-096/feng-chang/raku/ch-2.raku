#!/bin/env raku

sub levenshtein-distance(Str:D $s, Str:D $t) {
    my @S = $s.comb; my $m = @S.elems;
    my @T = $t.comb; my $n = @T.elems;

    my Array @a = (0 xx ($m+1)).Array xx ($n+1);
    @a[0;1..$m] = 1..$m;
    @a[1..$n;0] = 1..$n;

	for ^$n -> $j {
        for ^@S.elems -> $i {
            my $subst-cost = @S[$i] eq @T[$j] ?? 0 !! 1;

            @a[$j+1;$i+1] = min(
                @a[$j;$i+1] + 1,            # deletion
                @a[$j+1;$i] + 1,            # insertion
                @a[$j;$i] + $subst-cost     # substitution
            );
        }
    }
 
    @a[$n;$m], @a.item;
}

put levenshtein-distance('kitten', 'sitting')[0];
put levenshtein-distance('Saturday', 'Sunday')[0];
