use strict;
use warnings;

sub parse_input {
    my $what = shift;

    my @nums = ($what) =~ /=\s+(\d+).*?(\d+)/;

    return @nums;
}

sub get_bin_sum {
    my $what = shift;

    my ( $num1, $num2 ) = parse_input($what);

    return 0 unless $num1 * $num2;
    my $result   = '';
    my $overflow = 0;

    my $smaller = $num1;
    my $larger  = $num2;

    if ( length($num1) > length($num2) ) {
        $smaller = $num2;
        $larger  = $num1;
    }

    for my $num ( 1 .. length($larger) ) {
        my $add1 = substr( $larger, length($larger) - $num, 1 );

        my $add2 = 0;
        $add2 = substr( $smaller, length($smaller) - $num, 1 ) if $num <= length($smaller);

        my $sum = $add1 + $add2 + $overflow;

        if ( $sum < 2 ) {
            $overflow = 0;
            $result   = $sum . $result;
        }
        elsif ( $sum == 2 ) {
            $overflow = 1;
            $result   = "0" . $result;
        }
        else {
            $overflow = 1;
            $result   = "1" . $result;

        }

    }
    $result = "1" . $result if substr( $result, 0, 1 ) == "0";

    return $result;
}

use Test::More;

my ( $test_num1, $test_num2 ) = parse_input('$a = 11; $b = 1;');

is( $test_num1, 11 );
is( $test_num2, 1 );

is( get_bin_sum('$a = 1; $b = 1;'),  10 );
is( get_bin_sum('$a = 11; $b = 1;'), 100 );
is( get_bin_sum('$a = 10; $b = 1;'), 11 );
is( get_bin_sum('$a = 0; $b = 0;'),  0 );

done_testing;
