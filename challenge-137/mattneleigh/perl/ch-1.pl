#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @years = ();

print("\n");
for(1900 .. 2100){
    # See if this year is a long year...
    if(weeks_in_year($_) == 53){
        # Store it if it is...
        push(@years, $_);
        if($#years == 4){
            # There are five years stored- print
            # them out and flush the year-buffer
            print(join(", ", @years), "\n");
            @years = ();
        }
    }
}
if(@years){
    # Some unprinted years remain; print
    # them out too
    print(join(", ", @years), "\n");
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine how many weeks there are in a given year
# Takes one argument:
# * The year (e.g. 1937)
# Returns:
# * The number of weeks in the year, which will be either 52 or 53
################################################################################
sub weeks_in_year{
    my $year = shift();

    # Did this year end on Thursday or the
    # previous year end on Wednesday?
    if(
        (new_years_eve_weekday($year) == 4)
        ||
        (new_years_eve_weekday($year - 1) == 3)
    ){
        # Yes...
        return(53);
    } else{
        # No...
        return(52);
    }
    
}



################################################################################
# Determine on which day of the week December 31 falls in a given year
# Takes one argument:
# * The year (e.g. 1937)
# Returns:
# * The day of the week on which December 31 occurs in the given year, ranging
#   from 0 (Sunday) to 6 (Saturday)
################################################################################
sub new_years_eve_weekday{
    use POSIX;

    my $year = shift();

    return(
        (
            $year
            +
            floor($year / 4)
            -
            floor($year / 100)
            +
            floor($year / 400)
        )
        %
        7
    );

}



