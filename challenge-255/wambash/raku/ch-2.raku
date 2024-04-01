#!/usr/bin/env raku
use v6.e.PREVIEW;

sub most-frequent-word ($p,$w) {
    $p
    andthen .comb: /\w+/
    andthen .grep: { $_ !eq $w }\
    andthen .Bag
    andthen .max: *.value
    andthen .key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is most-frequent-word('Joe hit a ball, the hit ball flew far after it was hit.', 'hit'), 'ball';
    is most-frequent-word(
        'Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.',
        'the',
    ), 'Perl';
    done-testing;
}

multi MAIN ($p,$w) {
    say most-frequent-word $p,$w
}
