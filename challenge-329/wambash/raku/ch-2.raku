#!/usr/bin/env raku

sub nice-string ($str) {
    my @nice = (
        $str
        andthen .comb(/<:Lu>/)».lc ∩ .comb(/<:Ll>/)
        andthen .keys
    );

    $str
    andthen .comb: rx:i/<@nice>+/
    andthen .elems <= 1 ?? |$_ // '' !! .map: &nice-string
    andthen .max: *.chars
}

multi MAIN (Bool :test($)!) {
    use Test;
    is nice-string('YaaAho'), 'aaA';
    is nice-string('cC'), 'cC';
    is nice-string('A'), '';
    is nice-string('Cc'), 'Cc';
    is nice-string('YaaAhaAo'), 'aaA';
    is nice-string('YaaAhaAHo'), 'aaAhaAH';
    done-testing;
}

multi MAIN (+$str) {
    say nice-string $str;
}
