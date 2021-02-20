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
use DateTime::Format::DateParse;

sub convert_time {
    my $what = shift;

    my $pattern = $what =~ /m/ ? '%H:%M' : '%I:%M %P';

    return DateTime::Format::DateParse
        -> parse_datetime($what)
        -> strftime($pattern);

}

use Test::More;

is(convert_time('05:15pm'), '17:15');
is(convert_time('05:15 pm'), '17:15');
is(convert_time('19:15'), '07:15 pm');

done_testing;
