#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "a0b1c2",
    "abc12",
    "0a2b1c3",
    "1a23",
    "ab123"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        reorder_string($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting only of digits and letters, reorder the characters
# therein so that there are not two adjacent numbers or letters, and the
# resulting string has the smallest lexicographical value possible given the
# available characters
# Takes one argument:
# * The string to examine (e.g. "0a2b1c3")
# Returns:
# * A string containing all the letters and numbers from the provided string,
#   reordered as specified above (e.g. "0a1b2c3")
#   -- OR --
# * An empty string if the provided string cannot be reordered as specified
################################################################################
sub reorder_string{
    # Split the incoming string into characters and
    # sort them; numbers will be at the start of
    # the list
    my @letters = sort(split("", shift()));

    my @numbers;
    my $longer;
    my $shorter;
    my $reformatted;

    # Separate numbers from letters
    while($letters[0] =~ m/\d/){
        push(@numbers, shift(@letters));
    }

    # If the difference in the number of numbers
    # and letters won't permit them to be merged
    # without adjacent instances of either, return
    # an empty string
    return("")
        if(abs(scalar(@numbers) - scalar(@letters)) > 1);

    # Determine which list is the longer of the two;
    # if they are equal, assign numbers as the
    # "longer" one by default as they have a lower
    # lexicographical sorting value
    if(scalar(@letters) > scalar(@numbers)){
        $longer = \@letters;
        $shorter = \@numbers;
    } else{
        $longer = \@numbers;
        $shorter = \@letters;
    }

    # Merge the two character lists, longest first
    while(@{$shorter}){
        $reformatted .= shift(@{$longer});
        $reformatted .= shift(@{$shorter});
    }
    $reformatted .= shift(@{$longer})
        if(@{$longer});

    return($reformatted);

}



