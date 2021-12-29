#!/usr/bin/env raku
my regex palindrom { .+? <?{ $/ eq $/.flip}> };


sub palindromic-tree ($s) {
    $s
    andthen .match: &palindrom, :ex
    andthen .map: *.Str
    andthen .unique
}

multi MAIN (Bool :test($)!) {
    use Test;
    is palindromic-tree('redivider'),<r redivider e edivide d divid i ivi v>;
    is palindromic-tree('deific'),   <d e i ifi f c>;
    is palindromic-tree('rotors'),   <r rotor o oto t s>;
    is palindromic-tree('challenge'),<c h a l ll e n g>;
    is palindromic-tree('champion'), <c h a m p i o n>;
    is palindromic-tree('christmas'),<c h r i s t m a>;
    done-testing;
}

multi MAIN ($s) {
    say palindromic-tree $s
}
