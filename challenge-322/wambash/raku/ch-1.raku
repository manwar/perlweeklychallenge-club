#!/usr/bin/env raku

sub string-format ($str,:$i=3) {
    $str
    andthen .comb: /<-[-]>/
    andthen .reverse
    andthen .batch: $i
    andthen .map: *.reverse.join
    andthen .reverse
    andthen .join: '-'
}

multi MAIN (Bool :test($)!) {
    use Test;
    is string-format('ABC-D-E-F',:3i), 'ABC-DEF';
    is string-format('A-BC-D-E',:2i), 'A-BC-DE';
    is string-format('A-B-CD-E',:4i), 'A-BCDE';
    done-testing;
}

multi MAIN ($str,:$i=3) {
    say string-format $str,:$i;
}
