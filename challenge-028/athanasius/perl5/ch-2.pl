#!perl

################################################################################
=comment

Perl Weekly Challenge 028
=========================

Task #2
-------
Write a script to display *Digital Clock*. Feel free to be as creative as you
can when displaying digits. We expect bare minimum something like *"14:10:11"*.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use DateTime;

const my $TIMEZONE => 'Australia/Brisbane';

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $dt   = DateTime->now(time_zone => $TIMEZONE);
    my $hour = $dt->hour;       # 0-23
    my $min  = $dt->minute;     # 0-59
    my $sec  = $dt->second;     # 0-61 (leap seconds!)    

    printf "%02d:%02d:%02d\r", $hour, $min, $sec;

    while (1)
    {
        sleep 1;

        if (++$sec >= 60)
        {
            $sec = 0;

            if (++$min == 60)
            {
                $min  = 0;
                $hour = 0 if ++$hour == 24;
            }
        }

        printf "%02d:%02d:%02d\r", $hour, $min, $sec;
    }
}

################################################################################
