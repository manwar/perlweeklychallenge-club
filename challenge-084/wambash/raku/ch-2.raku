#!/usr/bin/env raku

sub is-square (@n, :@topleft ($x,$y), :$rank ) {
    so @n[ $x, $x+$rank ; $y, $y+$rank ].all == 1
}

multi find-square ( @n, :@topleft! ($x,$y) ) {
    my $rows     = @n.elems;
    my $columns  = @n[0].elems;
    1 ..^ ($rows - $x min $columns - $y)
    andthen .grep: { is-square @n, :topleft($x,$y), :rank($_) }\
    andthen .elems
}

multi find-square ( @n, ) {
    my $rows     = @n.elems;
    my $columns  = @n[0].elems;
    ^$rows X ^$columns
    andthen .grep: -> ($x, $y) { @n[$x;$y]==1 }\
    andthen .map:  { find-square @n, :topleft($_)  }\
    andthen .sum
}

multi MAIN (*@n) {
    say find-square @n.map: *.comb
}

multi MAIN (Bool :$test!) {
    use Test;
    my @n1=
    [ 0, 1, 0, 1, ],
    [ 0, 0, 1, 0, ],
    [ 1, 1, 0, 1, ],
    [ 1, 0, 0, 1, ],
    ;
    my @n2 =
    [ 1, 1, 0, 1, ],
    [ 1, 1, 0, 0, ],
    [ 0, 1, 1, 1, ],
    [ 1, 0, 1, 1, ],
    ;
    my @n3 =
    [ 0, 1, 0, 1, ],
    [ 1, 0, 1, 0, ],
    [ 0, 1, 0, 0, ],
    [ 1, 0, 0, 1, ],
    ;
    ok  is-square(@n1, :topleft(0,1), :rank(2));
    ok  is-square(@n2, :topleft(0,0), :rank(1));
    nok is-square(@n3, :topleft(0,0), :rank(1));
    is find-square( @n1, :topleft(0,1) ), 1;
    is find-square( @n2, :topleft(0,0) ), 2;
    is find-square( @n1 ), 1;
    is find-square( @n2 ), 4;
    is find-square( @n3 ), 0;
    done-testing;
}
