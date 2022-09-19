#!/usr/bin/env raku

my $*this-year = Date.today.truncated-to('year');

multi last-sundays (Int $year) {
    samewith Date.new: :$year
}

multi last-sundays (Date $year = $*this-year) {
    $year
    andthen $_, *.later( :1month ) ...^ *
    andthen .map: { .first-date-in-month .. .last-date-in-month }\
    andthen .map: *.first: *.day-of-week == 7, :end
    andthen .head: 12
}

multi MAIN (Bool :test($)!) {
    use Test;
    is last-sundays(2022), <
        2022-01-30 2022-02-27
        2022-03-27 2022-04-24
        2022-05-29 2022-06-26
        2022-07-31 2022-08-28
        2022-09-25 2022-10-30
        2022-11-27 2022-12-25
    >;
    done-testing;
}

multi MAIN (Int $year = 2022) {
    put last-sundays $year;
}
