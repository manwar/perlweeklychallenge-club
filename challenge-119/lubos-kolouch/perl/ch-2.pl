#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge #119
#               Task 2 - Sequence without 1-1
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 07/04/2021 04:44:33 PM
#===============================================================================

use strict;
use warnings;

sub get_nth_number {
    my $what = shift;

    my $pos = 0;
    my $target = 0;

    while ($target < $what) {
        $pos++;

        next if $pos =~ /[04-9]|11/;
        $target++;
    }

    return $pos;


}
use Test::More;

is(get_nth_number(5), 13);
is(get_nth_number(10), 32);
is(get_nth_number(60), 2223);
done_testing;

