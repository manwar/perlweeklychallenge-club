#https://theweeklychallenge.org/blog/perl-weekly-challenge-309/
# finds min gap elem:
use strict; use warnings; use v5.10; use Test::More tests => 6;
sub mge{!ref$_[0]?mge([9e999],@_):@_<3?$_[0][1]:mge($_[2]-$_[1]<$_[0][0]?[$_[2]-$_[1],$_[2]]:[$_[0][0],$_[0][1]],@_[2..$#_])}
for([ [2, 8, 10, 11, 15]       => 11 ],
    [ [1, 5, 6, 7, 14]         => 6 ],
    [ [8, 20, 25, 28]          => 28],
    [ [2, 3, 10, 12, 15, 16]   => 3 ],
    [ [8, 9]                   => 9 ],
    [ [8]                      => undef ]
){ my($inp,$want)=@$_; my $got = mge(@$inp); is $got, $want }
