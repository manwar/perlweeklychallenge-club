package main;
use strict;
use warnings;
use DateTime;

sub get_last_sunday {
    my ( $year, $month ) = @_;

    my $day =
      DateTime->last_day_of_month( year => $year, month => $month )->day;

    while (1) {
        my $dt = DateTime->new(
            year  => $year,
            month => $month,
            day   => $day
        );

        if ( $dt->day_of_week == 7 ) {
            return $dt->ymd;
        }

        $day--;
    }
    return 1;
}

sub get_sundays {
    my $year = shift;

    my @sundays;

    for ( 1 .. 12 ) {
        push @sundays, get_last_sunday( $year, $_ );
    }

    return \@sundays;
}

use Test::More;

is_deeply(
    get_sundays(2022),
    [
        '2022-01-30', '2022-02-27', '2022-03-27', '2022-04-24',
        '2022-05-29', '2022-06-26', '2022-07-31', '2022-08-28',
        '2022-09-25', '2022-10-30', '2022-11-27', '2022-12-25'
    ]
);
done_testing;
1;
