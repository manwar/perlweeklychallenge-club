#!/usr/bin/env perl

use v5.38;

sub senior_citizen (@passengers) {
    scalar grep {
        $_ =~ /
        \d{10}
        [A-Z]
        (\d\d)
        \d\d
    /x;
        $1 >= 60
    } @passengers;
}

sub MAIN() {
    if (@ARGV) {

        #| Run command line arguments
        say min_max(@ARGV);
    }
    else {
        #| Run test cases
        use Test2::V0 qw( is plan );
        plan 2;

        is senior_citizen(
            ( "7868190130M7522", "5303914400F9211", "9273338290F4010" ) ), 2,
          'works for ("7868190130M7522", "5303914400F9211", "9273338290F4010")';
        is senior_citizen( ( "1313579440F2036", "2921522980M5644" ) ), 0,
          'works for ("1313579440F2036", "2921522980M5644")';
    }
}

MAIN();
