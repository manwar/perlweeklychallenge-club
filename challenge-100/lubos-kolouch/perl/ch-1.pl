#!/usr/bin/perl
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: Perl Weekly Challenge #100
#               Task 1
#       AUTHOR: Lubos Kolouch
#      CREATED: 02/20/2021 10:16:51 AM
#===============================================================================

use strict;
use warnings;

sub convert_time {
    my $what = shift;
    (my $normalized = uc $what) =~ s/\s+//g;

    if ($normalized =~ /\A(\d{1,2}):(\d{2})(AM|PM)\z/) {
        my ($hour, $minute, $suffix) = ($1, $2, $3);
        $hour %= 12;
        $hour += 12 if $suffix eq 'PM';
        return sprintf '%02d:%02d', $hour, $minute;
    }

    if ($normalized =~ /\A(\d{1,2}):(\d{2})\z/) {
        my ($hour, $minute) = ($1, $2);
        my $suffix = $hour >= 12 ? 'pm' : 'am';
        $hour %= 12;
        $hour = 12 if $hour == 0;
        return sprintf '%02d:%02d %s', $hour, $minute, $suffix;
    }

    die "Invalid time format: $what";

}

use Test::More;

is(convert_time('05:15pm'), '17:15');
is(convert_time('05:15 pm'), '17:15');
is(convert_time('19:15'), '07:15 pm');

done_testing;
