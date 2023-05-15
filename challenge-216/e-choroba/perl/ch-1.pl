#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub registration_number($reg, @words) {
    my %required;
    @required{ map lc, $reg =~ /[a-z]/gi } = ();
    my @matches;

    for my $word (@words) {
        my %r = %required;
        delete @r{ split //, $word };
        next if keys %r;

        push @matches, $word;
    }
    return \@matches
}

use Test2::V0;
plan 3;

is registration_number('AB1 2CD', 'abc', 'abcd', 'bcd'), ['abcd'],
    'Example 1';
is registration_number('007 JB', 'job', 'james', 'bjorg'), ['job', 'bjorg'],
    'Example 2';
is registration_number('C7 RA2', 'crack', 'road', 'rac'), ['crack', 'rac'],
    'Example 3';
