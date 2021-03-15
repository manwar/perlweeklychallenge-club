#!/bin/env raku

grammar Dots {
    rule  TOP    { <coord>+ % ',' }
    rule  coord  { <[(]> <number> ** 2 % ',' <[)]> }
    token number { \d+ }
}

class DotsActions {
    method TOP($/)    { make $<coord>.map(*.made).Array }
    method coord($/)  { make $<number>.map(*.made).Array }
    method number($/) { make $/.UInt }
}

sub on-same-line(Array:D $dots -->Bool) {
    $dots.elems == 2 ||
    ([==] $dots.map({ .[0] })) ||
    ([==] (1..^$dots.elems).map({ ($dots[$_;1] - $dots[0;1])/($dots[$_;0] - $dots[0;0]) }));
}

sub max-dots(Array:D $dots -->UInt:D) {
    $dots.combinations(2..$dots.elems).grep({ on-same-line($_.Array) })».elems.max;
}

sub USAGE {
    put "./ch-1.raku test\n" ~
        "./ch-1.raku '(1,1), (2,2), (3,3)'\n" ~
        "./ch-1.raku '(1,1), (2,2), (3,1), (1,3), (5,3)'"
}

multi MAIN('test') {
    use Test;

    ok on-same-line([[1, 2], [1, 3], [1, -3]]), 'the 3 points are on the same vertical line';
    ok on-same-line([[1, 1], [2, 2], [3, 3]]), 'the 3 points are on the same line';
    nok on-same-line([[1, 1], [2, 2], [3, 1]]), 'the 3 points are not on the same line';

    is max-dots([[1,1], [2,2], [3,3]]), 3, '(1,1), (2,2), (3,3) => 3';
    is max-dots([[1,1], [2,2], [3,1], [1,3], [5,3]]), 3, '(1,1), (2,2), (3,1), (1,3), (5,3) => 3';

    is Dots.parse('123', :rule('number'), :actions(DotsActions)).made, 123, '"123" => 123';
    is-deeply Dots.parse('(3,5)',  :rule('coord'), :actions(DotsActions)).made, [3,5], '(3,5)  => [3,5]';
    is-deeply Dots.parse('(3, 5)', :rule('coord'), :actions(DotsActions)).made, [3,5], '(3, 5) => [3,5]';

    is-deeply Dots.parse('(3, 5), (1,2)', :actions(DotsActions)).made, [[3,5],[1,2]], '"(3, 5), (1,2)" => [[3,5],[1,2]]';
}

multi MAIN(Str:D $input) {
    put max-dots(Dots.parse($input, :actions(DotsActions)).made);
}
