#!/usr/bin/env raku

sub reverse-prefix (+$str, :$char) {
    my ($prefix, $root) = $str.split: / <?after "$char"> /, 2;

    $prefix.flip ~ $root
}

multi MAIN (Bool :test($)!) {
    use Test;
    is reverse-prefix('perl',:char<r>), 'repl';
    is reverse-prefix('programming',:char<g>), 'gorpramming';
    is reverse-prefix('hello',:char<h>), 'hello';
    is reverse-prefix('abcdefghij',:char<h>), 'hgfedcbaij';
    is reverse-prefix('reverse',:char<s>), 'srevere';
    done-testing;
}

multi MAIN (+$str, :$char) {
    say reverse-prefix $str, :$char;
}
