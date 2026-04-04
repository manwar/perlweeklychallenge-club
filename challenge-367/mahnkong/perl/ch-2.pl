use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub parse_time($string) {
    my @parts = split /:/, $string;
    my $time = $parts[0] * 60 + $parts[1];
    return $time;
}

sub run($event1, $event2) {
    my $start1 = parse_time($event1->[0]);
    my $end1 = parse_time($event1->[1]);
    my $start2 = parse_time($event2->[0]);
    my $end2 = parse_time($event2->[1]);

    if (($start1 > $start2 && $start1 < $end2) ||
       ($start2 > $start1 && $start2 < $end1) ||
       ($end1 > $start2 && $end1 < $end2) ||
       ($end2 > $start1 && $end2 < $end1)) {
       return 1;
    }
    return 0;

}

is(run(["10:00", "12:00"], ["11:00", "13:00"]), 1, 'Example 1');
is(run(["09:00", "10:30"], ["10:30", "12:00"]), 0, 'Example 2');
is(run(["14:00", "15:30"], ["14:30", "16:00"]), 1, 'Example 3');
is(run(["08:00", "09:00"], ["09:01", "10:00"]), 0, 'Example 4');
is(run(["23:30", "00:30"], ["00:00", "01:00"]), 1, 'Example 5');
