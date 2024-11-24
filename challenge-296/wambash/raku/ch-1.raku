#!/usr/bin/env raku

sub string-compression ($chars) {
    $chars.subst: /(\w)$0+/, { .chars ~ $0 }, :g
}

sub string-uncompression ($chars) {
    $chars.subst: /(\d+)(\w)/, { $1 x $0 }, :g
}

multi MAIN (Bool :test($)!) {
    use Test;
    is string-compression('abbc'),'a2bc';
    is string-compression('aaabccc'),'3ab3c';
    is string-compression('abcc'),'ab2c';
    is string-uncompression('a2bc'),'abbc';
    is string-uncompression('3ab3c'),'aaabccc';
    is string-uncompression('ab2c'),'abcc';
    done-testing;
}

multi MAIN ( $chars, :c(:compress($)) ) {
    say string-compression $chars
}

multi MAIN ( $chars, :u(:uncompress($))! ) {
    say string-uncompression $chars
}
