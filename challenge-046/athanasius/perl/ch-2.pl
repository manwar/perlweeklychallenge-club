#!perl

################################################################################
=comment

Perl Weekly Challenge 046
=========================

Task #2
-------
*Is the room open?*

There are 500 rooms in a hotel with 500 employees having keys to all the rooms.
The first employee opened main entrance door of all the rooms. The second
employee then closed the doors of room numbers 2,4,6,8,10 and so on to 500. The
third employee then closed the door if it was opened or opened the door if it
was closed of rooms 3,6,9,12,15 and so on to 500. Similarly the fourth employee
did the same as the third but only room numbers 4,8,12,16 and so on to 500. This
goes on until all employees has had a turn.

Write a script to find out all the rooms still open at the end.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $CLOSED =>   0;
const my $OPEN   =>   1;
const my $ROOMS  => 500;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my @rooms = (-1, ($CLOSED) x $ROOMS);

    for my $employee (1 .. $ROOMS)
    {
        for (my $door = $employee; $door <= $ROOMS; $door += $employee)
        {
            $rooms[$door] = ($rooms[$door] == $CLOSED ? $OPEN : $CLOSED);
        }
    }

    my @open = grep { $rooms[$_] == $OPEN } 1 .. $#rooms;

    printf "There are %d rooms still open at the end (the square-numbered " .
           "rooms):\n%s\n", scalar @open,
            join ', ', map { sprintf '%3d', $_ } @open;
}

################################################################################
