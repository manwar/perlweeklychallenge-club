#!/bin/env raku

sub MAIN(Str:D $grid where *.IO.e, Str:D $words where *.IO.e) {
    my Array @G;
    for $grid.IO.lines -> $line {
        @G.push($line.lc.trim-leading.split(/\s+/).Array);
    }
    my Int $max-row = @G.elems - 1;
    my Int $max-col = @G[0].elems - 1;
    #say $max-row, " ", $max-col;
    #say @G[0;0];
    #say @G[0;1];
    #say @G[1;0];
    #say @G[1;1];

    my Array @S;
    @S.push(@G».join.Array);
    @S.push(@G».reverse».join.Array);
    #say @S;
    for 1..$max-row -> Int $i {
        my Str ($s, $t);
        loop (my Int $j = 0; $j ≤ $max-col and $i - $j ≥ 0; ++$j) {
            $s ~= @G[$i - $j; $j];
            #            $t ~= @G[$max-row - $i - $j; $max-col - $j];
        }
        @S.push([$s, $s.flip, $t, $t.flip]);
    }
    #say @S;
    #say @S[*;*];
#    for 0..$max-col -> Int $j {
#        my Str ($s, $t);
#        loop (my Int $i = 0; 0 ≤ $i ≤ $max-row; ++$i) {
#            $s ~= @G[$i;$j];
#            $t ~= @G[$max-row - $i; $max-col - $j];
#        }
#        @S.push([$s, $s.flip, $t, $t.flip]);
#    }

    .say for @S[*;*].List;
}
