#!/usr/bin/env raku

sub workdays ( $year ) {
    Date.new: :$year
    andthen $_ ..^ .later: :1year
    andthen .grep: *.day-of-week !== 6|7
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is workdays(2021), 261;
    is workdays(2020), 262;
    done-testing;
}

multi MAIN ( $year ) {
    say workdays $year
}
