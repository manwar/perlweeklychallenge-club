#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @times = (
    "?2:34",
    "?4:?0",
    "??:??",
    "?3:45",
    "2?:15"
);

print("\n");
foreach my $time (@times){
    printf(
        "Input: \$time = \"%s\"\nOutput: %d\n\n",
        $time,
        count_valid_times($time)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string representing a time in the format "HH:MM" which may range from
# 00:00 to 23:59, but in which one or more digits have been replaced with
# question marks ('?'), determine how many valid times can be made by replacing
# the question marks with digits
# Takes one argument:
# * A time in the format described above in which one or more digits have been
#   replaced with question marks (e.g. "?4:?0")
# Returns:
# * The number of valid times that can be constructed by replacing question
#   marks with digits (e.g. 12)
################################################################################
sub count_valid_times{
    my $time = shift();

    my @digits;
    my $times = 0;

    $time =~ s/://;
    @digits = split('', $time);

    # Hours are a bit complicated...
    if($digits[0] eq '?'){
        # Tens place is a '?'
        if($digits[1] eq '?'){
            # Ones place is a '?'
            $times = 24;
        } else{
            # Ones place is not a '?'
            if($digits[1] < 4){
                # Ones place is 0-3
                $times = 3;
            } else{
                # Ones place is 4-9
                $times = 2;
            }
        }
    } elsif($digits[1] eq '?'){
        # Ones place is a '?' but the tens place was
        # NOT a '?'
        if($digits[0] == 2){
            # Tens place is a 2
            $times = 4;
        } else{
            # Tens place is not a 2 (therefore 0 or 1)
            $times = 10;
        }
    }

    # Minutes are easy...
    if($digits[2] eq '?'){
        # Tens place is a '?'
        if($times){
            $times *= 6;
        } else{
            $times += 6;
        }
    }
    if($digits[3] eq '?'){
        # Minutes place is a '?'
        if($times){
            $times *= 10;
        } else{
            $times += 10;
        }
    }

    return($times);

}



