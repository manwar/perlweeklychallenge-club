#!/usr/bin/env raku

my &letters = *.comb.Bag;

sub odd-charakter ($s,$t) {
    letters( $t ) ∖ letters( $s )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is odd-charakter('Perl','Peerl'),'e';
    is odd-charakter('Weekly','Weeakly'),'a';
    is odd-charakter('Box','Boxy'),'y';
    done-testing;
}

multi MAIN ($s,$t) {
    put odd-charakter $s,$t
}
