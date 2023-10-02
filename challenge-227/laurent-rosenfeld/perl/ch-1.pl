use strict;
use warnings;
use feature 'say';
use Time::Piece;

sub friday_13 {
    my $year = shift;
    my $count = 0;
    my $day = 13;
    for my $month (1..12) {
        my $dt = Time::Piece->strptime("$month/$day/$year",
            "%m/%d/%Y");
        $count++ if $dt->wday == 6;   # Friday == 6th day
    }
    return $count;
}
for my $year (2023..2030, 9998) {
    say $year, " => ", friday_13 $year;
}
