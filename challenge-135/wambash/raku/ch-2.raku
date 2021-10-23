#!/usr/bin/env raku

grammar SEDOL {
    token TOP {
        <char> ** 6  <check-digit>
    }

    token char {
        <+[0..9]+[A..Z]-[AEIOU]>
    }

    token check-digit {
        <[0..9]>
    }
}

class Validate-SEDOL {
    method TOP ($/) {
        |$<char>».made, $<check-digit>
        andthen $_ Z* 1, 3, 1, 7, 3, 9, 1
        andthen .sum
        andthen $_ %% 10
        andthen make $_
    }

    method char ($/) {
        make $/.Str.parse-base(35)
    }
}

multi MAIN ($sedol) {
    say +so SEDOL.parse( $sedol, :actions(Validate-SEDOL)).made ;
}

multi MAIN (Bool :test($)!){
    use Test;
    is SEDOL.parse('2936921').<check-digit>, '1';
    is SEDOL.parse('2936921', :actions(Validate-SEDOL)).made, True;
    is SEDOL.parse('1234567', :actions(Validate-SEDOL)).made, False;
    is SEDOL.parse('B0YBKL9', :actions(Validate-SEDOL)).made, True;
    done-testing;
}
