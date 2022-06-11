#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @words;

# Examine all lines from STDIN...
while(<>){
    chomp;

    # Skip blank lines
    next
        if(m/^$/);

    # Split the line on whitespace and loop over
    # each returned string...
    WORD:
    foreach(split(" ", $_)){
        if(length($_) > 1){
            # Word is more than one character long;
            # examine it
            foreach my $pos (1 .. length($_) - 1){
                # Break to the next word if a character
                # has an ordinal value that isn't less
                # than or equal to the one before it
                next WORD
                    unless(
                        ord(substr($_, $pos - 1, 1))
                        <=
                        ord(substr($_, $pos, 1))
                    );
            }
            # Got here- all the characters are
            # in the right order; store the abecedarian
            # word
            push(@words, $_);
        } else{
            # Word is single-character;
            # automatically store it
            push(@words, $_);
        }
    }
}

# Print out the stored abecedarian words, sorted in
# descending order by length
if(@words){
    print(join("\n", sort({ length($b) <=> length($a) } @words)), "\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



