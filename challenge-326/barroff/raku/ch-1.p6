#!/usr/bin/env raku

use v6.d;

sub day-of-the-year(Str $date --> Int) {
    my $end-date = Date.new($date);
    my $start-date = Date.new($end-date.year, 1, 1);
    $end-date - $start-date + 1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is day-of-the-year('2025-02-02'), 33, 'works for "2025-02-02"';
    is day-of-the-year('2025-04-10'), 100, 'works for "2025-04-10"';
    is day-of-the-year('2025-09-07'), 250, 'works for "2025-09-07"';
}

#| Take user provided string like 2025-02-02
multi sub MAIN(Str $date) {
    say day-of-the-year($date);
}
