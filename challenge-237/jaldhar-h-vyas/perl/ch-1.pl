#!/usr/bin/perl
use 5.030;
use warnings;
use English;
use DateTime;

sub ordinal {
    my ($day) = @_;
    return $day . (
        ($day % 10 == 1 && $day != 11)
        ? 'st'
        : ($day % 10 == 2 && $day != 12)
            ? 'nd'
            : ($day % 10 == 3 && $day != 13)
                ? 'rd'
                : "th"
    );
}

my ($year, $month, $weekday, $dayofweek) = @ARGV;

my $dt = DateTime->new(year => $year, month => $month, day => 1);

my $diff = abs($dayofweek -  $dt->day_of_week);

eval { $dt->set(day => 1 + (7 * ($weekday - 1)) + $diff); };

if ($EVAL_ERROR) {
    $dt->set(day => 1 + $diff + 1);
    say "There isn't a ", ordinal($weekday), ' ', $dt->day_abbr,' in ',
        $dt->month_abbr, ' ', $year;
} else {
    say 'The ', ordinal($weekday), ' ', $dt->day_abbr,' of ', $dt->month_abbr,
        ' ', $year, ' is the ', ordinal($dt->day);
}