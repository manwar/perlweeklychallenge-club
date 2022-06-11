use strict;
use warnings;

sub calc_isbn_digit {
    my $what = shift;

    my $mul = 1;

    my $sum = 0;

    for my $char ( split //, $what ) {
        next unless $char =~ /\d/;

        $sum += $char * $mul;

        $mul = $mul == 1 ? 3 : 1;
    }

    $sum %= 10;
    $sum = 10 - $sum;
    $sum = 0 if $sum == 10;

    return $sum;
}

use Test::More;

is( calc_isbn_digit('978-0-306-40615-?'), 7 );
done_testing;
