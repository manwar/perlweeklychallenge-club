use v5.36;
use DateTime;

sub last_sundays_in ( $year ) {
    my @r;
    for my $month (1..12) {
        my $dt = DateTime->last_day_of_month( year => $year, month => $month );

        $dt->subtract(days => 1) while $dt->day_name ne 'Sunday';

        push @r, $dt;
    }
    return @r;
}

say $_->ymd for last_sundays_in( shift // 2022 );
