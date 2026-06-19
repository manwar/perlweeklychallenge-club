#!/usr/bin/perl
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-028/
#               Display the current time in a simple digital format.
#
#===============================================================================

use strict;
use warnings;
use feature qw/say/;
use POSIX qw(strftime);

sub get_time {
    return strftime("%H:%M:%S", localtime);
}

say get_time();

# TESTS
use Test::More;
like(get_time(), qr/^\d{2}:\d{2}:\d{2}$/, "Returns time in HH:MM:SS format");
done_testing;
