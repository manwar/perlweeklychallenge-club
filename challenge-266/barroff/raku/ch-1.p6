#!/usr/bin/env raku

use v6.d;

sub common-words(Str:D $sentence1, Str:D $sentence2 --> Positional) {
    my Bag $word-bag = $sentence1.split(/\s/).Bag (+) $sentence2.split(/\s/).Bag;
    my @candidates = sort(grep({ $word-bag{$_} == 1 }, $word-bag.keys));
    return @candidates ?? @candidates !! ('',);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is common-words('Mango is sweet', 'Mango is sour'), ('sweet', 'sour').sort,
        'works for "Mango is sweet"';
    is common-words('Mango Mango', 'Orange'), ('Orange'),
        'works for "Mango Mango"';
    is common-words('Mango is Mango', 'Orange is Orange'), (''),
        'works for "Mango is Mango"';
}

#| Take user provided word like CAT
multi sub MAIN(Str:D $str) {
    say common-words($str, '');
}

#| Take user provided words like CAT DOG CAT
multi sub MAIN(*@str where @str.elems > 1) {
    say common-words(@str[0], @str[1 .. * - 1].join(' '));
}
