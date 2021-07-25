#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @args = (10, 20, 30, 40, 50, 60, 70, 80, 90);

stream_average(@args);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Print to STDOUT a running average of a list of numbers- that is to say, for
# each number in the list, print the average of every number seen up to that
# point, including said number
# Takes a list of numbers as a series of arguments; this list may be of any
# length
# Returns no meaningful value
################################################################################
sub stream_average{

    my $i;
    my $accumulator = 0;

    for($i=0; $i<scalar(@ARG); $i++){
        $accumulator += $ARG[$i];
        print(
            $accumulator / ($i + 1),
            ($i == $#ARG) ? "\n" : ", "
        );
    }

}



