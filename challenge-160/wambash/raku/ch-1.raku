#!/usr/bin/env raku
constant @NUMBER = <zero one two three four five six seven eight nine ten>;

sub four-is-magic ($n) {
    @NUMBER[$n], {@NUMBER[.chars]} ...^ * eq *
    andthen |$_, 'magic'
    andthen .rotor: 2 => -1
    andthen .map: { .[0] ~ ' is ' ~ .[1] }\
    andthen .join(", ").tc ~ q{.}

}

multi MAIN (Bool :test($)!) {
    use Test;
    is four-is-magic(5), 'Five is four, four is magic.';
    is four-is-magic(7), 'Seven is five, five is four, four is magic.';
    is four-is-magic(6), 'Six is three, three is five, five is four, four is magic.';
    done-testing;
}

multi MAIN ($n) {
    say four-is-magic $n
}
