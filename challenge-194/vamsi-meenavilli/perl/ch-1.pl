#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

     Week 194:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-194

    Task 1: Digital Clock
    Submitted by: Mohammad S Anwar
    You are given time in the format hh:mm with one missing digit.

    Write a script to find the highest digit between 0-9 that makes it valid time.

=cut

is(digitalClock('?5:00'), 1, 'Test Case 1 Failed.');
is(digitalClock('?3:00'), 2, 'Test Case 2 Failed.');
is(digitalClock('1?:00'), 9, 'Test Case 3 Failed.');
is(digitalClock('2?:00'), 3, 'Test Case 4 Failed.');
is(digitalClock('12:?5'), 5, 'Test Case 5 Failed.');
is(digitalClock('12:5?'), 9, 'Test Case 6 Failed.');

sub digitalClock {
    my ($time) = @_;

    $time =~ m/\?/g;
    my $missing_character_index = pos($time) - 1;
    $time =~ s/\?/9/;
    my ($hour, $minute) = split(/:/, $time);

    if ($missing_character_index < 2) {
        while (int($hour) > 23) {
            substr($hour, $missing_character_index, 1, substr($hour, $missing_character_index, 1) - 1);
        }

        return(substr($hour, $missing_character_index, 1))
    }
    else {
        $missing_character_index -= 3;
        while (int($minute) > 59) {
            substr($minute, $missing_character_index, 1, substr($minute, $missing_character_index, 1) - 1);
        }

        return(substr($minute, $missing_character_index, 1))
    }
}

done_testing();
