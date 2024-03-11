use v5.30.0;
use warnings;
use Date::Simple;
use List::Util qw/any/;

sub bh {
    my $start_date = $_[0];
    my $offset = $_[1];
    my $bank_holidays = $_[2];
    $bank_holidays = [] if !defined($bank_holidays);
    my $day = Date::Simple->new($start_date);
    my $count = $offset;
    while ($count != 0) {
        $day = $day->next;
        if ($day->day_of_week == 0 || $day->day_of_week == 6 
                || 
            (any {$day == $_} $bank_holidays->@*)) {
        } 
        else {
            $count--;
        }
    }
    return sprintf($day);
}

use Test::More tests=>2;
ok '2018-07-04' eq bh('2018-06-28', 3, ['2018-07-03']);
ok '2018-07-03' eq bh('2018-06-28', 3);
