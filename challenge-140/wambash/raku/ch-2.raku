#!/usr/bin/env raku

constant @multiplication-table = (
    (1, 2 ... *) Z, (2,4 ... *)
    andthen .map: { |$_... * }\
    andthen *.map: *.cache
);

sub multiplication-table ($k, $i=$k div 2+1, $j=$i) {
    @multiplication-table
    andthen .map: *.head($j)
    andthen .head($i)
    andthen .flat.sort
    andthen .[$k-1]
}

multi MAIN (Bool :test($)!) {
    use Test;
    is multiplication-table(4),3;
    is multiplication-table(4,2,3),3;
    is multiplication-table(6,3,3),4;
    is multiplication-table(150),39;
    done-testing;
}

multi MAIN ($k, $i=$k div 2 + 1, $j=$i) {
    say multiplication-table $k, $i, $j
}
