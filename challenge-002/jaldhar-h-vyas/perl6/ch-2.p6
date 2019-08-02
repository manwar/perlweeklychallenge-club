#!/usr/bin/perl6
# Thanks to ugexe on #perl6 for help with option parsing.

multi sub MAIN(
    $number,            #= the number to convert
    Bool :$f! where .so #= convert base 35 number to base 10
) {
    say $number.parse-base(35);
}

multi sub MAIN(
    $number,
    Bool :$t! where .so #= convert base 10 number to base 35
) {
    say $number.base(35);
}

