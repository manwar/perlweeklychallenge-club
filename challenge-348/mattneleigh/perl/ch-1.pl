#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "textbook",
    "book",
    "AbCdEfGh",
    "rhythmmyth",
    "UmpireeAudio"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %s\n\n",
        $string,
        vowels_balanced($string) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether the number of vowels in the first half of a string with an
# even number of characters is balanced with the number of vowels in the second
# half; any condition involving zero vowels in either half is considered a
# mismatch, even if both halves are vowel-less
# Takes one argument:
# * The string to examine (e.g. "AbCdEfGh")
# Returns:
# * A value that evaluates as true if the halves of the string have a balanced
#   quantity of vowels (as would be the case in the example above)
# * A value that evaluates as false if the halves of the string do NOT have a
#   balanced quantity of vowels, or if either half has zero vowels
################################################################################
sub vowels_balanced{
    # Store the lower-cased input string in the second
    # position in the array, since extracting the
    # first half therefrom later is simpler
    my @halves = ( undef, lc(shift()) );

    # Extract the first half of the input string,
    # modifying the input value to only contain the
    # second half
    $halves[0] = substr($halves[1], 0, (length($halves[1]) / 2), "");

    # Loop over the two halves of the string
    for my $i (0 .. 1){
        # Count the vowels by splitting the half-string
        # into a list of characters, filtering out
        # anything that isn't a vowel, then counting the
        # members of the filtered list; this count
        # replaces the half-string in the array
        $halves[$i] = scalar(grep(/[aeiou]/, split("", $halves[$i])));

        # If there are no vowels in either half, return a
        # false value, since any condition involving zero
        # vowels is considered a mismatch
        return("")
            unless($halves[$i]);
    }

    # Compare the counts and return
    return($halves[0] == $halves[1]);

}



