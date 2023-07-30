#!/usr/bin/env raku

sub friday-thirteenth ($year) {
    Date.new: :$year, :13day
    andthen $_, *.later(:1month)  ...^ .later(:1year)
    andthen .grep: *.day-of-week == 5
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is friday-thirteenth(2023), 2;
    done-testing;
}

multi MAIN ($year) {
    say friday-thirteenth $year
}
