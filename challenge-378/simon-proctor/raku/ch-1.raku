#!/usr/bin/env raku

subset IsTrue of Bool where so *;

multi sub MAIN( IsTrue :t(:$test) ) is hidden-from-USAGE {
    use Test;
    is second-largest-digit("aaaaa77777"), Nil;
    is second-largest-digit("abcde"), Nil;
    is second-largest-digit("9zero8eight7seven9"),8;
    is second-largest-digit("xyz9876543210"),8;
    is second-largest-digit("4abc4def2ghi8jkl2"),4;
    done-testing;
}

#|(
Given an alphanumeric string.

Find the second largest distinct digit in the given string. Return -1 if none found.
)
multi sub MAIN(
    Str $testString #= String to test
) {
    say second-largest-digit( $testString ) // -1;
}

sub second-largest-digit(Str $a) { $a.comb(/\d/).unique.sort.reverse[1] }
