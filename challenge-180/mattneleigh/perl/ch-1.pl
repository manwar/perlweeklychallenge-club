#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    "Perl Weekly Challenge",
    "Long Live Perl",

    # Additional test cases
    "We must repeat... We must repeat..."
);

print("\n");
foreach my $string (@strings){
    my $pos = first_unique_character($string);

    printf("Input: \$s = \"%s\"\n", $string);
    printf(
        "Output: %s\n\n",
        defined($pos) ?
            sprintf(
                "%d as '%s' is the first unique character",
                $pos,
                substr($string, $pos, 1)
            )
            :
            "Undefined, as there are no unique characters"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the location of the first unique character (that is to say, the first
# character that appears only once) in a string
# Takes one argument:
# * The string to examine
# Returns on success:
# * The zero-indexed position of the first unique character in the string
# Returns on failure:
# * undef if there are no unique characters in the string
################################################################################
sub first_unique_character{

    my %table;
    my $i = 0;

    # Loop over all characters in the supplied
    # string
    foreach my $char (split('', shift())){
        if(defined($table{$char})){
            # Character we have seen before- mark it as
            # not unique
            $table{$char}{unique} = 0;
        } else{
            # Character we haven't seen before- create
            # a new table entry and note its initial
            # position
            $table{$char} = {
                init_pos => $i,
                unique   => 1
            };
        }
        $i++;
    }


    # Grab a list of positions of unique characters
    # seen in the string, sort them in ascending order,
    # then capture the first number from the sorted
    # list in $i; if no unique characters were found,
    # this will be undefined
    ($i) = sort(
        { $a <=> $b }
        map(
            $table{$_}{unique} ? $table{$_}{init_pos} : (),
            keys(%table)
        )
    );

    return($i);

}



