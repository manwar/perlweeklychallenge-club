use strict;
use warnings;

sub is_esthetic_number {
    my $what = shift;

    # where is enumerate when you need it

    my @arr = split //, $what;
    for my $elem ( 0 .. scalar @arr - 2 ) {
        return 0 unless abs( $arr[$elem] - $arr[ $elem + 1 ] ) == 1;
    }

    return 1;
}

use Test::More;

is( is_esthetic_number(5456), 1, 'Test 5456' );
is( is_esthetic_number(120),  0, 'Test 120' );

done_testing;
