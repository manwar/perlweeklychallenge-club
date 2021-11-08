use strict;
use warnings;

# just a rewrite of the wiki JS code
#

sub get_letter_value {
    my $what = shift;

    return $what if $what =~ /\d/;
    return 9 + ord($what) - ord('A') + 1;
}

sub checkSedol {
    my $text = shift;

    my $input       = substr( $text, 0, 6 );
    my $check_digit = sedol_check_digit($input);

    return 0 unless $text eq $input . $check_digit;
    return 1;
}

sub sedol_check_digit {
    my $char6 = shift;

    return -1 unless ( $char6 =~ /^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}$/ );
    my @weight = ( 1, 3, 1, 7, 3, 9, 1 );

    my $sum = 0;
    for my $i ( 0 .. length($char6) - 1 ) {
        $sum += $weight[$i] * get_letter_value( substr( $char6, $i, 1 ) );
    }
    my $check = ( 10 - $sum % 10 ) % 10;

    return $check;
}

use Test::More;

is( get_letter_value('B'), 11 );
is( get_letter_value(1),   1 );

is( checkSedol('0263494'), 1 );
is( checkSedol('2936921'), 1 );
is( checkSedol('1234567'), 0 );
is( checkSedol('B0YBKL9'), 1 );

done_testing;
