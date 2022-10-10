#!/usr/bin/env raku

multi split-array (Str $s) {
    $s
    andthen .words
    andthen .classify: *.uniprop
}

multi split-array (+@s) {
    @s
    andthen .map: { split-array $_ }\
    andthen .flat
    andthen .classify: *.key, as => *.value
}
multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply split-array('a 1 2 b 0')<Ll Nd>,( ['a', 'b'], ['1', '2', '0']);
    is-deeply split-array('3 c 4 d')<Ll Nd>,( ['c', 'd'], ['3', '4']);
    is-deeply split-array('a 1 2 b 0','3 c 4 d')<Ll Nd>,( [['a', 'b'],['c','d']], [['1', '2', '0'],['3','4']]);
    is-deeply split-array('1 2', 'p q r', 's 3', '4 5 t')<Nd Ll>,( [['1', '2'],['3',],['4','5']], [['p', 'q', 'r'],['s'],['t']]);
    done-testing;
}

multi MAIN (*@s) {
    say split-array @s
}
