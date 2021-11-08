#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @args = (15, 25);
my $answers;

# Sort args just for general safety-
# numbers_without_one() expects a
# sorted list
@args = sort({$a <=> $b} @args);

$answers = numbers_without_one(@args);

foreach(@args){
    # Grab a slice from the array of numbers matching
    # our search criteria, ranging from zero to the next
    # index in the indices list, which corresponds to
    # the sequence found for the original argument
    # presently held in $_
    my @numbers = @{$answers->{numbers}}[0..shift(@{$answers->{indices}})];

    printf(
        "There are %d numbers between 1 and %d that don't contain digit 1:\n",
        scalar(@numbers),
        $_
    );
    printf("    %s\n\n", join(", ", @numbers));
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find a series of integers that do not contain the digit '1'
# Takes one argument:
# * A list of integers, which must be sorted in ascending order
# Returns:
# * A ref to a hash containing the following fields:
#   {
#       numbers => [], # A list of numbers between 2 and the highest number
#                      # in the argument list, none of which contain '1'
#       indices => []  # A list of indices that indicate which number in the
#                      # numbers list corresponds to the highest number found
#                      # for each of the supplied arguments
#   }
################################################################################
sub numbers_without_one{

    # Don't bother checking 1- it happens
    # to contain '1'
    my $num = 2;
    my $found = {
        numbers => [],
        indices => [],
    };

    while(1){
        # Treat the number like a string
        # because we can
        if($num !~ m/1/){
            # Number did not have a '1' in it-
            # store it in the list of found
            # numbers
            push(@{$found->{numbers}}, $num);
        }
        if($num == $ARG[0]){
            # $num matches the 0th member of the
            # remaining arguments- store the
            # index of the current last member
            # of the found number list in the
            # list of indices
            push(
                @{$found->{indices}},
                $#{$found->{numbers}}
            );

            # Strip the 0th element from @ARG and
            # break the loop if @ARG is empty
            shift(@ARG);
            last unless(@ARG);
        }
        $num++;
    }

    return($found);

}



