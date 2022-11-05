#!/usr/bin/env raku

sub greater-charakter ($target,+@array) {
   @array
   andthen .grep( * gt $target ) || $target
   andthen .min: *.ord - $target.ord
}

multi MAIN (Bool :test($)!) {
    use Test;
    is greater-charakter('b', <e m u g>), 'e';
    is greater-charakter('a', <d c e f>), 'c';
    is greater-charakter('o', <j a r>  ), 'r';
    is greater-charakter('a', <d c a f>), 'c';
    is greater-charakter('v', <t g a l>), 'v';
    done-testing;
}

multi MAIN ($target, *@array) {
    say greater-charakter $target, @array
}
