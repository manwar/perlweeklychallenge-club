#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @years = (
    2021,
    2020
);
my $year;

foreach $year (@years){
    print("Input: \$year = $year\n");
    print("Output: ", workdays_per_year($year), "\n\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the number of workdays (Monday through Friday, inclusive) in a
# given year.  This function does NOT take any holidays into account.
# Takes one argument:
# * The year to examine
# Returns on success:
# * The number of workdays (see definition above) in that year
################################################################################
sub workdays_per_year{
    my $year = shift();

    # Shamelessly borrow from a solution
    # to a previous PWC problem, with a
    # few modifications...
    my $nye_curr = new_years_eve_weekday($year);
    my $nye_prev = new_years_eve_weekday($year - 1);
    my $weeks = weeks_in_year($year, $nye_curr, $nye_prev);


    return(
        # Number of workdays in the first
        # partial week of the year
        (5 - ($nye_prev == 6 ? 5 : $nye_prev))
        +
        # Number of workdays in the full
        # weeks ofthe year
        (($weeks - ($weeks == 53 ? 2: 1)) * 5)
        +
        # Number of workdays in the last
        # partial week of the year
        ($nye_curr == 6 ? 5 : $nye_curr)
    );

}



################################################################################
# Determine how many weeks there are in a given year
# Takes one argument:
# * The year (e.g. 1937)
# * The day of the week on which December 31 occurs in the given year, ranging
#   from 0 (Sunday) to 6 (Saturday) (e.g. 5)
# * The day of the week on which December 31 occurs in the year BEFORE the
#   given year (e.g. 4)
# Returns:
# * The number of weeks in the year, which will be either 52 or 53
################################################################################
sub weeks_in_year{
    my $year = shift();
    my $nye_curr = shift();
    my $nye_prev = shift();

    # Did this year end on Thursday or the
    # previous year end on Wednesday?
    if(
        ($nye_curr == 4)
        ||
        ($nye_prev == 3)
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



