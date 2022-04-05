#!/usr/bin/env raku

#| Output the Farey Sequence of order n
sub MAIN ( Int \n ) {
    ((0..n) X/ (1..n)).grep( * <= 1 ).unique.sort.map( *.nude ).map( { "@_[0]/@_[1]" } ).join(", ").say
}
