#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main($time) {
    my $value = '';
    if (substr($time, 0, 1) eq '?') {
        # 2 if the second hour value is <= 3 else 1
        $value = substr(time, 1, 1) <= 3 ? 2 : 1;
    }
    elsif (substr(time, 1, 1) eq '?') {
        # 3 if the first hour value is 2 else 9
        $value = substr(time, 1, 1) == 2 ? 3 : 9;
    }
    elsif (substr(time, 3, 1) eq '?') {
        # The maximum first minute value is always 5
        $value = 5;
    }
    else {
        # The maximum second minute value is always 9
        $value = 9;
    }

    say $value;
}

main($ARGV[0]);