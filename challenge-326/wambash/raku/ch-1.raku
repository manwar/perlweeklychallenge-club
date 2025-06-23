#!/usr/bin/env raku


sub day-of-the-year (Date() $_) {
    .succ - .truncated-to: 'year'
}

multi MAIN (Bool :test($)!) {
    use Test;
    is day-of-the-year('2025-02-02'),  33;
    is day-of-the-year('2025-04-10'), 100;
    is day-of-the-year('2025-09-07'), 250;
    done-testing;
}

multi MAIN (Date() $date) {
    say day-of-the-year $date;
}
