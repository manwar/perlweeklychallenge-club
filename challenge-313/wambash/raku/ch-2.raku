#!/usr/bin/env raku

sub reverse-letters ($str) {
    sprintf $str.trans( /<:alpha>/ => "%s"), $str.comb(/<:alpha>/).reverse
}

multi MAIN (Bool :test($)!) {
    use Test;
    is reverse-letters('p-er?l'),'l-re?p';
    is reverse-letters('wee-k!L-y'),'yLk-e!e-w';
    is reverse-letters('_c-!h_all-en!g_e'),'_e-!g_nel-la!h_c';
    done-testing;
}

multi MAIN ($str) {
    say reverse-letters $str
}
