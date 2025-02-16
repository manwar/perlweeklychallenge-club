#!/usr/bin/env raku

sub count-common (@str1,@str2) {
    @str1.Bag ∩ @str2.Bag
    andthen .total
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-common(<perl weekly challenge>,<raku weekly challenge>), 2;
    is count-common(<perl raku python>,<python jave>), 1;
    is count-common(<guest contribution>,<fun weekly challenge>), 0;
    done-testing;
}

multi MAIN ($str1,$str2) {
    say count-common $str1.words,$str2.words
}
