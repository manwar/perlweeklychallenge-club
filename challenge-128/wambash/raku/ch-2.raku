#!/usr/bin/env raku

sub minimum-platforms (@arrivals, @deparatures) {
    |(@arrivals X=> 1), |(@deparatures X=> -1)
    andthen .sort
    andthen .map: *.value
    andthen [\+] $_
    andthen .max
}

multi MAIN (Bool :test($)! ) {
    use Test;
    is minimum-platforms( <11:20 14:30>, <11:50 15:00> ), 1;
    is minimum-platforms( <10:20 11:00 11:10 12:20 16:20 19:00>, <10:30 13:20 12:40 12:50 20:20 21:20> ), 3;
    done-testing;
}
