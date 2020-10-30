#! /usr/bin/raku

constant INT_MAX = 2_147_483_647;

sub flip(Int \number) {
    number > INT_MAX ?? 0 !! number.abs.flip * number.sign;
}

#############################################################################

use Test;

is flip(2147483648), 0, 'Integer last + 1';
is flip(99999999999999999999999999), 0, 'Big number';
is flip(1), 1, 'Small number';
is flip(0), 0, 'Zero, no sign';
is flip(-0), 0, 'Zero, with sign is still zero';
is flip(123), 321, '123=321';
is flip(2147483641), 1463847412, '2147483641=1463847412';
is flip(-2147483641), -1463847412, '-2147483641=-1463847412';

done-testing;
