use strict;
use warnings;

sub get_middle_numbers {
    my $what = shift;

    # handle -
    $what = abs($what);

    my $length = length($what);

    return "Even count of numbers" if $length % 2 == 0;

    return "Too short" unless $length >= 3;

    return substr( $what, int( $length / 2 ) - 1, 3 );

}

use Test::More;

is( get_middle_numbers(1234567), 345 );
is( get_middle_numbers(-123),    123 );
is( get_middle_numbers(1),       "Too short" );
is( get_middle_numbers(10),      "Even count of numbers" );

done_testing;
