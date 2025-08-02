#!/usr/bin/env raku

sub uncommon-words (+lines) {
    lines
    andthen .words
    andthen .Bag
    andthen .nodemap: * == 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    cmp-ok uncommon-words('Mango is sweet', 'Mango is sour'), &[≡],('sweet','sour');
    cmp-ok uncommon-words('Mango is Mango', 'Orange is Orange'), &[≡], Empty;
    cmp-ok uncommon-words('Mango Mango', 'Orange'), &[≡], ('Orange');
    done-testing;
}

multi MAIN (+lines) {
    put uncommon-words lines
}
