#!/usr/bin/env raku
my rule row  { (\d+)+ %% ',' };
my rule matrix { <row>+ %% ';' }

sub kronecker-product (@a, @b) {
    @a XX* @b
    andthen .map: *.list
}

multi MAIN (Bool :test($)!) {
    use Test;
    my @a:= ( 1,2; 3,4; );
    my @b:= ( 5,6; 7,8; );
    my @c:= ( 5,6,10,12; 7,8,14,16; 15,18,20,24; 21,24,28,32 );
    is-deeply kronecker-product(@a,@b), @c;
    is '1,2'.match(&row)[0], (1,2);
    is-deeply '1,2;3,4'.match(&matrix)<row>».[0]».Int, ([1,2],[3,4]);
    done-testing;
}

multi MAIN ($a, $b) {
    say kronecker-product $a.match(&matrix).<row>».[0], $b.match(&matrix).<row>».[0];
}
