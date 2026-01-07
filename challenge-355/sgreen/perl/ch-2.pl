#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    if ($#ints < 2) {
        say "false";
        return;
    }

    my $direction = 'up';
    my $last_int = $ints[0];

    if ($ints[1] <= $last_int) {
        # Ensure that we start by going up
        say "false";
        return;
    }

    foreach my $current_int (@ints[1 .. $#ints]) {
        if ($current_int == $last_int) {
            say "false";
            return;
        }
        if ($direction eq 'up') {
            if ($current_int < $last_int) {
                $direction = 'down';
            }
        }
        else {  # direction == 'down'
            if ($current_int > $last_int) {
                say "false";
                return;
            }
        }

        $last_int = $current_int;
    }

    if ($direction eq 'up') {
        # Ensure we went up and then down
        say "false";
        return;
    }

    say "true";
}

main(@ARGV);