#!/usr/bin/env raku

sub caesar-cipher ($s, :$n=3) {
    $s
    andthen .trans: <A>..<Z> => (<A>..<Z>).List.rotate: -$n
}

multi MAIN (Bool :$test!) {
    use Test;
    is caesar-cipher('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG'), 'QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD';
    is caesar-cipher('ABCDEFGHIJKLMNOPQRSTUVWXYZ'), 'XYZABCDEFGHIJKLMNOPQRSTUVW';
    is caesar-cipher(caesar-cipher('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG')):n(-3), 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG';
    done-testing
}

multi MAIN ($s, :$n=3) {
    say caesar-cipher $s, :$n
}
