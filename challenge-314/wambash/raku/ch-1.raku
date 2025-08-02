#!/usr/bin/env raku

sub equal-strings (+@str) {
    my $same-start-chars = (
        @str.head.comb
        andthen [\~] $_
        andthen .first: { @str.all.starts-with: $_ }, :end
        andthen .chars
    );

    $same-start-chars ?? sum @str.map: { $^s.chars - $same-start-chars } !! Nil
}

multi MAIN (Bool :test($)!) {
    use Test;
    is equal-strings('abc','abb','ab'), 2;
    is equal-strings('ayz','cyz','xyz'), Nil;
    is equal-strings(<yza yzb yzc>), 3;
    done-testing;
}

multi MAIN (+str) {
    say equal-strings str
}
