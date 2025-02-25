#https://theweeklychallenge.org/blog/perl-weekly-challenge-309/
# finds min diff:
use strict; use warnings; use v5.10; use Test::More tests => 6;
sub md{!ref$_[0]?md(\9e999,sort{$a<=>$b}@_):@_<3?${$_[0]}:md(abs($_[2]-$_[1])<${$_[0]}?\abs($_[2]-$_[1]):$_[0],@_[2..$#_])}
for([ [1, 5, 8, 9]  => 1 ],
    [ [9, 4, 1, 7]  => 2 ],
){ my($inp,$want)=@$_; my $got = md(@$inp); is $got, $want }
