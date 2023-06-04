#!/usr/bin/env raku
use v6.e.*;

sub travel-expenditure  (+@days, *%costs (:$day, :$week, :$month)) {
    my Str @day-plan is default('x') ;
    @day-plan[|@days] = 'T' xx *;
    my token day { <!after T ** 6> T }
    my token week {  T <?before T x* T> <[Tx]> ** 1..6 }
    my token month { T <?before T [<[Tx]> **? 6..28] T> <[Tx]> ** 7..29  }

    @day-plan.join
    andthen .match: / ^ x* [  <month> | <week> | <day> ]+ %% x*  $/, :ex
    andthen .map: *.caps.map: *.key
    andthen .map: { %costs{|$_}.sum  }\
    andthen .min
}

multi MAIN (Bool :test($)!) {
    use Test;
    is travel-expenditure( 1,3,4,5,6):5day:30week:90month, 25;
    is travel-expenditure( 1, 5, 6, 7, 9, 15,:2day:7week:25month), 11;
    is travel-expenditure( 1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31,:2day:7week:25month), 20;
    done-testing;
}

multi MAIN (+@days, :d($day)!,:w($week)!,:m($month)!) {
    say travel-expenditure  @days, :$day, :$week, :$month
}
