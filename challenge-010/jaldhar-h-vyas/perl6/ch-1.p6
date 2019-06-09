#!/usr/bin/perl6

grammar RomanNumerals {
    token TOP {
        <thousands>? <hundreds>? <tens>? <ones>?
    }

    token thousands {
        <ThreeM> | <TwoM> | <OneM>
    }

    token hundreds {
        <NineC> | <EightC> | <SevenC> | <SixC> | <FiveC> | <FourC> | <ThreeC> | 
        <TwoC> | <OneC>
    }

    token tens {
        <NineX> | <EightX> | <SevenX> | <SixX> | <FiveX> | <FourX> | <ThreeX> |
        <TwoX> | <OneX>
    }

    token ones {
        <NineI> | <EightI> | <SevenI> | <SixI> | <FiveI> | <FourI> | <ThreeI> |
        <TwoI> | <OneI>
    }

    token ThreeM { MMM }
    token TwoM { MM }
    token OneM { M }

    token NineC { CM }
    token EightC { DCCC }
    token SevenC { DCC }
    token SixC { DC }
    token FiveC { D }
    token FourC { CD }
    token ThreeC { CCC }
    token TwoC { CC }
    token OneC { C }

    token NineX { XC }
    token EightX { LXXX }
    token SevenX { LXX }
    token SixX { LX }
    token FiveX { L }
    token FourX { XL }
    token ThreeX { XXX }
    token TwoX { XX }
    token OneX { X }

    token NineI { IX }
    token EightI { VIII }
    token SevenI { VII }
    token SixI { VI }
    token FiveI { V }
    token FourI { IV }
    token ThreeI { III }
    token TwoI { II }
    token OneI { I }
}

class RomanNumeralsAction {
    method TOP($/) {
        make $/.values».made.sum;
    }

    method thousands($/) {
        make $/.values[0].made;
    }

    method hundreds($/) {
        make $/.values[0].made;
    }

    method tens($/) {
        make $/.values[0].made;
    }

    method ones($/) {
        make $/.values[0].made;
    }

    method ThreeM($/) { make 3000; }
    method TwoM($/)   { make 2000; }
    method OneM($/)   { make 1000; }

    method NineC($/)  { make 900; }
    method EightC($/) { make 800; }
    method SevenC($/) { make 700; }
    method SixC($/)   { make 600; }
    method FiveC($/)  { make 500; }
    method FourC($/)  { make 400; }
    method ThreeC($/) { make 300; }
    method TwoC($/)   { make 200; }
    method OneC($/)   { make 100; }

    method NineX($/)  { make 90; }
    method EightX($/) { make 80; }
    method SevenX($/) { make 70; }
    method SixX($/)   { make 60; }
    method FiveX($/)  { make 50; }
    method FourX($/)  { make 40; }
    method ThreeX($/) { make 30; }
    method TwoX($/)   { make 20; }
    method OneX($/)   { make 10; }

    method NineI($/)  { make 9; }
    method EightI($/) { make 8; }
    method SevenI($/) { make 7; }
    method SixI($/)   { make 6; }
    method FiveI($/)  { make 5; }
    method FourI($/)  { make 4; }
    method ThreeI($/) { make 3; }
    method TwoI($/)   { make 2; }
    method OneI($/)   { make 1; }
}

sub fromRoman(Str $number where .uc) {
    my $decimal = RomanNumerals.parse($number,
                    actions => RomanNumeralsAction.new);
    if defined $decimal {
        return $decimal.made;
    }
    return 0;
}

sub toRoman(Int $number where { $number >= 1 && $number <= 3000 }) {
    my Str $result;

    given ($number div 1000) {
        when 1 { $result ~= 'M'; }
        when 2 { $result ~= 'MM'; }
        when 3 { $result ~= 'MMM'; }
        default {}
    }

    given ($number div 100 % 10) {
        when 1 { $result ~= 'C'; }
        when 2 { $result ~= 'CC'; }
        when 3 { $result ~= 'CCC'; }
        when 4 { $result ~= 'CD'; }
        when 5 { $result ~= 'D'; }
        when 6 { $result ~= 'DC'; }
        when 7 { $result ~= 'DCC'; }
        when 8 { $result ~= 'DCCC'; }
        when 9 { $result ~= 'CM'; }
        default {}
    }

    given ($number div 10 % 10) {
        when 1 { $result ~= 'X'; }
        when 2 { $result ~= 'XX'; }
        when 3 { $result ~= 'XXX'; }
        when 4 { $result ~= 'XL'; }
        when 5 { $result ~= 'L'; }
        when 6 { $result ~= 'LX'; }
        when 7 { $result ~= 'LXX'; }
        when 8 { $result ~= 'LXXX'; }
        when 9 { $result ~= 'XC'; }
        default {}
    }

    given ($number % 10) {
        when 1 { $result ~= 'I'; }
        when 2 { $result ~= 'II'; }
        when 3 { $result ~= 'III'; }
        when 4 { $result ~= 'IV'; }
        when 5 { $result ~= 'V'; }
        when 6 { $result ~= 'VI'; }
        when 7 { $result ~= 'VII'; }
        when 8 { $result ~= 'VIII'; }
        when 9 { $result ~= 'IX'; }
        default {}
    }

    return $result;
}

multi sub MAIN(
    $number,            #= the number to convert
    Bool :$f! where .so #= convert Roman numerals to a decimal number
) {
    say fromRoman($number);
}

multi sub MAIN(
    $number,
    Bool :$t! where .so #= convert a number (between 1 and 3000) to Roman numerals
) {
    say toRoman($number.Int);
}