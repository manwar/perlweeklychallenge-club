#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

my $MIN_PER_HOUR    =  60;
my $DIFF_PER_MINUTE =  11;  # Half degrees
my $FULL_CIRCLE     = 720;  # Half degrees

while (<>) {
    my ($hours, $minutes) = /[0-9]+/g;
    #
    # Every minute, the angle between the hour and minute hand
    # increases by 5.5 degrees. So, we will calculate how many
    # minutes have passed since 00:00, multiply this by 11, giving
    # us the number of half degrees between two hands.
    # We normalize the angle by modding it by 720. To get the smaller
    # angle, if the angle is more than 360, we subtract the angle
    # from 720 (the full circle).
    #
    # Finally, we divide by 2, to get the answer in degrees.
    #

    #
    # Note that this is going to work regardless whether the
    # time is given in 12 hour format, a 24 hour format, or
    # the silly format Americans use.
    #

    my $angle = ($DIFF_PER_MINUTE * ($hours * $MIN_PER_HOUR + $minutes)) %
                 $FULL_CIRCLE;
       $angle =  $FULL_CIRCLE - $angle if 2 * $angle >= $FULL_CIRCLE;

    say $angle / 2;
}

__END__
