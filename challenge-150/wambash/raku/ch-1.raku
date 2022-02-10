#!/usr/bin/env raku

sub fibonacci-words ($a,$b) {
    $a, $b, * ~ * ... *.chars > 50
}

multi MAIN (Bool :test($)!) {
    use Test;
    is +fibonacci-words('1234','5678'), 7;
    is fibonacci-words('1234','5678').list, <1234 5678 12345678 567812345678 12345678567812345678 56781234567812345678567812345678 1234567856781234567856781234567812345678567812345678>;
    done-testing;
}

multi MAIN ($a,$b) {
    put +fibonacci-words $a,$b
}
