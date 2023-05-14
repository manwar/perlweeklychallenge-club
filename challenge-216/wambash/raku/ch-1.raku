#!/usr/bin/env raku
use v6.e.*;

sub registration-number (+@words, :$reg!) {
    my &letters = *.lc.comb(/<:alpha>/).Bag;
    my Bag $reg-letters = letters $reg;
    @words.grep:  $reg-letters ⊆ *.&letters
}

multi MAIN (Bool :test($)!) {
    use Test;
    is registration-number(<abc abcd bcd>, :reg('AB1 2CD')), ('abcd',);
    is registration-number(<job james bjorg>, :reg('007 JB')), ('job', 'bjorg');
    is registration-number(<crack road rac>, :reg('C7 RA2')), ('crack', 'rac');
    done-testing;
}

multi MAIN (*@words,:$reg!) {
    say registration-number @words, :$reg
}
