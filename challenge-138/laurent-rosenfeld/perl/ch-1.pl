use warnings;
use feature qw/say/;
use Time::Piece;

sub work_days {
    my $y = shift;
    my $count = 52 * 5;
    my $t = Time::Piece->strptime("$y Dec 31", '%Y %b %e');
    my $last_d = $t->day_of_week;
    $count++ if $last_d > 0 and $last_d < 6;
    if ($t->is_leap_year) {
        my $thirtieth = ($last_d - 1) % 7;
        $count++ if $thirtieth > 0 and $thirtieth < 6;
    }
    return $count;
}
say "$_ -> ", work_days $_ for 2000..2021;
