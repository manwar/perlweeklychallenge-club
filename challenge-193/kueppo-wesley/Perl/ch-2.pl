#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ state say /;

use Test::More;

sub find_odd_string {
    state %mapper = map { ( 'a' .. 'z' )[$_] => $_ } 0 .. 25;

    for my $string (@_) {
        my @mapped     = map { $mapper{$_} } split //, $string;
        my @translated = map { $mapped[ $_ + 1 ] - $mapped[$_] } 0 .. $#mapped - 1;

        return @translated if grep { $_ < 0 } @translated;
    }
}

my %test_data = (
                  expected => [ [ 3, -1 ],         [ 13, -13 ] ],
                  samples  => [ [qw(adc wzy abc)], [qw(aaa bob ccc ddd)] ],
);

is_deeply( [ map { [ find_odd_string(@$_) ] } $test_data{samples}->@* ], $test_data{expected}, "did you find odd strings?" );

done_testing(1);
