#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@inputs) {
    my %str1 = map { $_, 1 } split( /\s+/, $inputs[0] );
    my %str2 = map { $_, 1 } split( /\s+/, $inputs[1] );

    my $count = 0;
    foreach my $str ( keys %str1 ) {
        $count++ if exists $str2{$str};
    }

    say $count;
}

main(@ARGV);
