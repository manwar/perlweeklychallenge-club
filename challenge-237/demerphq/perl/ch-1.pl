use strict;
use warnings;
use Time::Local qw(timegm_posix);

# Seize The Day
#
sub mday_for_week_dow {
    my ($year_num, $month, $week, $dow)= @_;

    my $time = timegm_posix( 0, 0, 12, 1, $month, $year_num );
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);

    while (1) {
        ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)= gmtime($time);
        last if $wday == $dow;
        $time += (24 * 60 * 60);
    }
    for (;$week;$week--) {
        ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)= gmtime($time);
        return 0 if $mon != $month;
        $time += (24 * 60 * 60) * 7;
    }
    return $mday+1;
}

my @day_name= qw(Sun Mon Tue Wed Thu Fri Sat);
my @month_name= qw(Jan Feb Mar Apr May Jun Jul Aug Sept Oct Nov Dec);

sub num_suffix {
    my ($n)= @_;
    return $n . ($n == 1 ? "st" : $n == 2 ? "nd" : $n == 3 ? "rd" : "th");
}

for my $tuple (
    [2024,  4, 1, 2],
    [2025, 10, 2, 4],
    [2026,  8, 5, 3],

) {
    my ($year, $month, $week, $dow)= @$tuple;
    my $mday = mday_for_week_dow($year, $month-1, $week, $dow);
    printf "The %s %s of %s %s %s\n",
          num_suffix($week),
          $day_name[$dow],
          $year,
          $month_name[$month-1],
          $mday ? "is the ".num_suffix($mday) : "does not exist";
}
