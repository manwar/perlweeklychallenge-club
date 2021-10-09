#!/usr/bin/env raku

sub mirror-dates (Date() $birth, Date() :$today = Date.today ) {
    my $age = $today - $birth;
    $birth - $age, $today + $age
}


multi MAIN ($birth, :$today = Date.today) {
    put mirror-dates $birth, :$today
}

multi MAIN (Bool :test($)!) {
    use Test;
    is mirror-dates( '2021-09-18', :today<2021-09-22> ), <2021-09-14 2021-09-26>;
    is mirror-dates( '1975-10-10', :today<2021-09-22> ), <1929-10-27 2067-09-05>;
    is mirror-dates( '1967-02-14', :today<2021-09-22> ), <1912-07-08 2076-04-30>;
    done-testing
}
