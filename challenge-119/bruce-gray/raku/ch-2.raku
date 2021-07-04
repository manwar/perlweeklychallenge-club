#!/usr/bin/env raku
# Each "generation" contains the same number of digits.
sub s123 ( Int $n where * > 0 ) {
    sub next_generation ( @a ) {
        return [ ( <1 2 3> X~ @a ).grep: {!/11/} ];
    }
    constant @s = ( [""], &next_generation ... * ).map(*.<>).flat;
    return @s[$n];
}


multi sub MAIN ( *@n ) {
    say $_, " ==> ", .&s123 for +«@n;
}
multi sub MAIN ( ) {
    use Test;
    my @tests =
          5 =>   13,
         10 =>   32,
         60 => 2223,
    ;
    plan +@tests;
    is s123(.key), .value, "nib {.key.fmt('%3d')} ==> {.value.fmt('%4d')}" for @tests;
}
