#!/usr/bin/env raku

use v6.d;

my $bin-format = sub ($self) {
    sprintf "%d-%d-%d",
    .year.base(2),
    .month.base(2),
    .day.base(2)
    given $self;
}

sub binary-date(Str $date --> Str) {
    Str(Date.new($date, formatter => $bin-format))
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is binary-date("2025-07-26"), "11111101001-111-11010",
        'works for "2025-07-26"';
    is binary-date("2000-02-02"), "11111010000-10-10",
        'works for "2000-02-02"';
    is binary-date("2024-12-31"), "11111101000-1100-11111",
        'works for "2024-12-31"';
}

#| Take user provided date like "2025-07-26"
multi sub MAIN(Str $date) {
    say binary-date($date);
}
