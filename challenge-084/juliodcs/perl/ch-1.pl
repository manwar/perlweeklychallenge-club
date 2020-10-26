use strict;
use warnings;
use feature 'say';
use experimental 'signatures';
use bigint;

use constant INT_LAST => 2_147_483_647;

sub flip($number) {
    my $sign = $number < 0 ? q(-) : q();
    my $numb = join q(), reverse split m//, abs $number;
    return $numb > INT_LAST ? 0 : $sign . $numb;
}

if (@ARGV == 1) {
    say flip(shift);
    exit 0;
}

use Test::More;

is flip(2147483648), 0, 'Integer last + 1';
is flip(99999999999999999999999999), 0, 'Big number';
is flip(1), 1, 'Small number';
is flip(0), 0, 'Zero, no sign';
is flip(-0), 0, 'Zero, with sign is still zero';
is flip(123), 321, '123=321';
is flip(2147483641), 1463847412, '2147483641=1463847412';
is flip(-2147483641), -1463847412, '-2147483641=-1463847412';

done_testing;
