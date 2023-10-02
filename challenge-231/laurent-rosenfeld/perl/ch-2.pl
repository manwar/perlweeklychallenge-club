use strict;
use warnings;
use feature 'say';

sub count_seniors {
    return scalar (grep { substr($_, 11, 2) >= 60 } @_);
}
for my $test
    ([<7868190130M7522 5303914400F9211 9273338290F4010>],
     [<1313579440F2036 2921522980M5644>]) {
    printf "...%-s  ", substr($_, 11, 4) for @$test;
    say " => ", count_seniors @$test;
}
