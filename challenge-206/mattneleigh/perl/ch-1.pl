#!/usr/bin/perl

use strict;
use warnings;
use English;

use List::Util qw(min);

################################################################################
# Begin main execution
################################################################################

my @time_lists = (
    [ "00:00", "23:55", "20:00" ],
    [ "01:01", "00:50", "00:57" ],
    [ "10:10", "09:30", "09:00", "09:55" ]
);

print("\n");
foreach my $time_list (@time_lists){
    printf(
        "Input: \@time = (%s)\nOutput: %d\n\n",
        join(", ", map("\"$_\"", @{$time_list})),
        shortest_time_interval_in_list(@{$time_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the shortest interval between any two times in HH:MM format within
# a list, in minutes.  Note that the shortest interval may pass through
# midnight (00:00); if so, this function does not report that this was the
# case.  The order in which the times appear in the list does not affect the
# calculation, and the shortest time may not be between adjacent members of
# the list; this function does not report between which times the calculated
# interval occurred.
# Takes one argument:
# * The list of times to examine
# Returns:
# * The shortest interval between the various times n the list, in minutes; see
#   notes above
################################################################################
sub shortest_time_interval_in_list{

    return(
        # min() is from List::Util
        min(
            # Get a list of intervals between all times
            # in the argument list- do this with nested
            # calls to map() in which $i and the inner
            # $_ will, as array indices, refer to all
            # pairs in the list
            map(
                {
                    # Capture the outer $_
                    my $i = $_;

                    map(
                        calculate_time_interval_pair(
                            $ARG[$i],
                            $ARG[$_]
                        ),
                        ($i + 1) .. $#ARG
                    );
                }
                0 .. ($#ARG - 1)
            )
        )
    );

}



################################################################################
# Calculate the shortest inverval, in minutes, between two times in HH:MM
# format.  Note that the shortest interval may pass through midnight (00:00);
# if so, this function does not report that this was the case.  The order in
# which the arguments appear does not affect the calculation.
# Takes two arguments:
# * The first time to examine
# * The second time to examine
# Returns:
# * The time interval between the specified times, in minutes; see notes above
################################################################################
sub calculate_time_interval_pair{
    my $a = shift();
    my $b = shift();

    # Convert HH:MM format to minutes since
    # midnight
    $a =~ m/^(\d+):(\d+)$/;
    $a = 60 * $1 + $2;
    $b =~ m/^(\d+):(\d+)$/;
    $b = 60 * $1 + $2;

    # Make sure $b is larger than $a
    ($b, $a) = ($a, $b)
        if($a > $b);

    # Return the minimum of the two possible
    # distances between the two times.  1440
    # is the number of minutes in a day;
    # min() is from List::Util
    return(
        min(
            ($b - $a),
            (1440 - $b + $a)
        )
    );

}



