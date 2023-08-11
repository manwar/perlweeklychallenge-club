#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
229-2: Two out of Three         Submitted by: Mohammad S Anwar

Given three array of integers, return all the elements that are present in at
least 2 out of 3 given arrays.

Example 1
Input: @array1 = (1, 1, 2, 4)
       @array2 = (2, 4)
       @array3 = (4)
Ouput: (2, 4)
Example 2
Input: @array1 = (4, 1)
       @array2 = (2, 4)
       @array3 = (1, 2)
Ouput: (1, 2, 4)
=end comment

#                   Not actually creating the diminished array.

my @Test =
      # results for but = 0…N         input is @e[*-1]
    ( [4,], [2, 4],  [1,2,4],         ( (1,1,2,4), (2,4), (4,)    ),  ),
    ( [,],  [1,2,4], [1,2,4],         [ [4,1],      [2,4], [1,2], ],  ),
    ( (),   (1,),    (1,),   (1,),    ( (1,),(1,),(1,),(),        ),  ),
    ( (),   (1,),    (1,2),  (1,2,3), ( (1,2,3),(1,2,),(1,),(),   ),  ),
;
plan 16;

# Select elems which are in all @pop.elems. With the :$but var select
# elem values which exist in at least that many fewer @pop.elems.
sub common( @pop, UInt :$but is copy -->List) {
    $but //= 0;
    my %b = (flat @pop.map( *.unique)).Bag;
    do for %b.keys { $_ if %b{$_} ≥ @pop.elems -$but }
}

for @Test -> @t {
    if @t[*-1] == 3 {
        is (  (@t[*-1][0] ∩ @t[*-1][1])
            ∪ (@t[*-1][0] ∩ @t[*-1][2])
            ∪ (@t[*-1][1] ∩ @t[*-1][2])
          ).keys.sort,
             @t[1].sort, 'union of 3 intersections of 3 sets';
        }
    for 0..^ @t-1 -> $i {
        is common(@t[*-1], :but($i)).sort , @t[$i],
                "@t[$i].raku() <- @t[*-1].raku() but $i";
    }
}
done-testing;

my @array = [ (1,4,5,2,3,7,1,2,4,9,4), (7,5,1,9,6,3), (3,2,9),
                (1,9,1,6,2,7,2), (9,2,7,5,4)];

say "\nInput: \@array[0] = @array[0].raku()";
for 1..^@array { say "       \@array[$_] = @array[$_].raku()" }
say "Ouput: ", common( @array, :but(1));
exit;

