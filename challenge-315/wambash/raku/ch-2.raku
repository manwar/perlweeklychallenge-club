#!/usr/bin/env raku

sub find-third ($first, $second, $sentence) {
    my $fs = qq{<?after :r:i:s "$first" "$second" >};
    $sentence.comb: /<$fs> \w+/
}

multi MAIN (Bool :test($)!) {
    use Test;
    is find-third(
        'My', 'favourite',
        'Perl is a my favourite language but Python is my favourite too.'
    ), <language too>;
    is find-third(
        'a', 'beautiful',
        'Barbie is a beautiful doll also also a beautiful princess.'
    ), <doll princess>;
    is find-third(
        'we', 'will',
        'we will we will rock you rock you.'
    ), <we rock>;
    done-testing;
}

multi MAIN ($first, $second, $sentence) {
    put find-third $first, $second, $sentence
}
