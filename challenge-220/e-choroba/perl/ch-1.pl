#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

sub common_characters(@words) {
    my %seen;
    for my $i (0 .. $#words) {
        ++$seen{$_}[$i] for split //, lc $words[$i];
    }

    return [map +(($_) x min(@{ $seen{$_} })),
            sort
            grep { @words == grep $_, @{ $seen{$_} } }
            keys %seen]
}

use Test2::V0;
plan 3;

is common_characters(qw( Perl Rust Raku )), [qw[ r ]], 'Example 1';
is common_characters(qw( love live leave )), [qw[ e l v ]], 'Example 2';
is common_characters(qw( feel peel steel )), [qw[ e e l ]], 'Repetition';
