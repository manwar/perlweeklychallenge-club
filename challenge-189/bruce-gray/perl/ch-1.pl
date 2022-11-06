#!/usr/bin/env perl
use v5.36;
use List::Util qw<minstr>;

sub task1 ( $aref, $target ) {
    my @gt = grep { $_ gt $target } @{$aref};

    return @gt ? minstr(@gt) : $target;
}


my @tests = (
    [ [qw<e m u g>], 'b', 'e' ],
    [ [qw<d c e f>], 'a', 'c' ],
    [ [qw<j a r  >], 'o', 'r' ],
    [ [qw<d c a f>], 'a', 'c' ],
    [ [qw<t g a l>], 'v', 'v' ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ( $aref, $target,  $expected ) = @{$_};
    is task1($aref, $target), $expected, "task1(qw<@{$aref}>)";
}
