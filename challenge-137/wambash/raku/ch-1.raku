#!/usr/bin/env raku

enum DOW (Thursday => 4);

sub is-long-year ($year ) {
    | Date.new( :$year )
    | Date.new( year => $year+1)-1
    andthen   .day-of-week == Thursday
}

multi MAIN () {
    1900 .. 2100
    andthen Supply.from-list: $_
    andthen .grep: &is-long-year
    andthen .batch: :5elems
    andthen .map: *.fmt: '%4d', ', '
    andthen .tap: *.say;
}

multi MAIN (Bool :test($)!) {
    use Test;
    ok is-long-year( $_ )   for 1903, 2032, 2099;
    nok is-long-year( $_ )  for 1901, 2033, 2098;
    done-testing;
}
