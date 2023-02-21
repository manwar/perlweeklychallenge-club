#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ « ␤ » ∴
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment

202-2: Widest Valley            Submitted by: E. Choroba
Given a profile as a list of altitudes, return the leftmost widest valley.
A valley is defined as a subarray of the profile consisting of two parts:
the first part is non-increasing and the second part is non-decreasing.
Either part can be empty.
=end comment

my @Test =
    { in  => Empty,                         exp => Empty, },
    { in  => [1,],                          exp => [1,], },
    { in  => [1,5],                         exp => [1,5], },

    { in  => [1,2,3],                       exp => [1,2,3], },
    { in  => [3,2,1],                       exp => [3,2,1], },
    { in  => [1,2,3,3,2,1],                 exp => [1,2,3,3], },
    { in  => [2,3,3,2,1],                   exp => [3,3,2,1], },

    { in  => [3,2,1,1,2,3],                 exp => [3,2,1,1,2,3], },
    { in  => [3,2,1,2,3],                   exp => [3,2,1,2,3], },

    { in  => [1,1,1],                       exp => [1,1,1], },

    { in  => [5,5,2,5,5],                   exp => [5,5,2,5,5], },
    { in  => [1,1,1,1,5,5,2,5,5],           exp => [1,1,1,1,5,5], },
    { in  => [5,5,2,5,5,1,1,1,1],           exp => [5,5,1,1,1,1], },
    { in  => [1,5,5,2,5,5,1,1,1,1],         exp => [5,5,1,1,1,1], },
    { in  => [1,5,5,2,5,5,1,1,1],           exp => [5,5,2,5,5], },

    { in  => [9,8,13,13,2,2,15,17],         exp => [13,13,2,2,15,17], },
    { in  => [2,1,2,1,3],                   exp => [2,1,2], },
    { in  => [1,3,3,2,1,2,3,3,2],           exp => [3,3,2,1,2,3,3], },
    { in  => [2,2,2,1,1,1,1,2,1,1,1,3],     exp => [ 2,2,2,1,1,1,1,2], },
    { in  => [1,2,1,1,2,2,2,2,2,1,2,1],     exp => [2,1,1,2,2,2,2,2], },
    { in  => [1,2,1,1,2,2,2,2,2,1,1,2,2,1], exp => [2,2,2,2,2,1,1,2,2], },
;

multi find-big-valley( @a where Empty ~~ * ) { [,] }
multi find-big-valley( @a where @a.end ≤ 1) { @a }

multi find-big-valley( @a --> Array) {
                                        # COULDDO  bail when best > remainder
    my ($h, $t, $hi-score, @best) = 0 xx 5;
    loop {
        ++$t while $t < @a.end and @a[$t] == @a[$t+1];   # Cross 1st flat area.
        if $t == @a.end {
            score( $h,$t);
            last;
        }
        if @a[$t] < @a[$t+1] {                    ### Started mid valley.
            ascend-slope;
            score-done-or-reset-for-more;
        } else {                                 ### Start looping valleys.
            loop {
                descend-slope;
                ascend-slope;
                score-done-or-reset-for-more;
    }   }   }

    return [@a[ @best.head..@best.tail]] ;

    die 'not reached, only scope contained subs follow';

                    sub score-done-or-reset-for-more () {
                        score( $h, $t);
                        $h = $t;
                        last if $t == @a.end;
                        --$h  while $h > 0 and @a[$h] == @a[$h-1]; # Re-use plateau.
                    }
                    sub score( $h, $t) {
                        if $t-$h > $hi-score {
                            @best = $h,$t; $hi-score = $t-$h 
                        }
                    }
                    sub ascend-slope() {
                        ++$t while $t < @a.end and @a[$t] ≤ @a[$t+1];
                    }
                    sub descend-slope() {
                        ++$t while $t < @a.end and @a[$t] ≥ @a[$t+1];
                    }
}

plan +@Test;
for @Test -> %h {
    is find-big-valley( %h<in>), %h<exp>;
}
done-testing;

my @input = 3,3,2,1,1,1,2,3,3,3,3,2,1,1,1,1,1,2,2,1;
say "\n Input: ", @input.join: ', ';
say "Output: ", find-big-valley( @input).join: ', ';

