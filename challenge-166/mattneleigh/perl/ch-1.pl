#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my %words_by_length;
my @words;

# Read in all lines of input from STDIN- must
# be one word per line
while(<>){
    my $length;
    my $hexed;

    chomp;

    # Skip 7 as there will be no words of
    # length 1 to add
    $length = length($_);
    next
        if(7 == $length);

    # Catalog each successfully hexified word
    # by its length; store both the hexified
    # and original (but capitalized) versions
    $hexed = hexify_text($_);
    push(@{$words_by_length{$length}}, [$hexed, uc($_)])
        if(defined($hexed));
}

# Now, make some 8-character combos...
# General cases- 2, 3
for(2 .. 3){
    foreach my $a (@{$words_by_length{$_}}){
        foreach my $b (@{$words_by_length{8 - $_}}){
            # Add both possible combinations
            push(
                @words,
                [$a->[0].$b->[0], $a->[1].$b->[1]],
                [$b->[0].$a->[0], $b->[1].$a->[1]]
            );
        }
    }
}

# Special case- 4
for my $a (0 .. ($#{$words_by_length{4}} - 1)){
    for my $b ($a .. $#{$words_by_length{4}}){
        push(
            @words,
            [
                $words_by_length{4}[$a][0].$words_by_length{4}[$b][0], 
                $words_by_length{4}[$a][1].$words_by_length{4}[$b][1] 
            ],
            # If $a and $b are the same, the combo only
            # needs to be added once...
            ($a == $b) ? () :
            [
                $words_by_length{4}[$b][0].$words_by_length{4}[$a][0],
                $words_by_length{4}[$b][1].$words_by_length{4}[$a][1]
            ]
        );
    }
}

# Special case- 8
push(@words, splice(@{$words_by_length{8}}, 0));

# Sort the finished word list in order by the
# un-hexed string
@words = sort({ $a->[1] cmp $b->[1] } @words);

# Produce output
foreach(@words){
    print($_->[0], " (", $_->[1], ")\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Convert a word into a hexadecimal-friendly version, if possible
# Takes one required argument and one optional argument:
# * The string to convert, which must be at least two (2) characters long, but
#   not more than eight (8) characters long (e.g. "accolade")
# * An optional argument that, if defined, enables expanded hex conversions
#   (see below)
# Returns on success:
# * The converted string (e.g. "ACC01ADE"); the alphabetic characters in this
#   string will be uppper case
# Returns on error:
# * undef if the string contains characters for which no conversion is
#   specified, or is not of the correct length
# NOTE: The conversions performed are:
#   O -> 0
#   L -> 1
#   I -> 1
#   S -> 5
#   T -> 7
# Expanded conversions also include:
#   Z -> 2
#   G -> 6
################################################################################
sub hexify_text{
    my $text = uc(shift());
    my $expanded = shift();

    # Return undef if the text is not within
    # specified length bounds
    return(undef)
        if((length($text) < 2) || (length($text) > 8));

    # Substitute some characters
    if(defined($expanded)){
        # Expanded substitutions
        $text =~ tr/[OLIZSGT]/[0112567]/;
    } else{
        # Standard substitutions
        $text =~ tr/[OLIST]/[01157]/;
    }

    # Return undef if here were non-hex
    # characters after substitution
    return(undef)
        if($text =~ m/[^0-9A-F]/);

    return($text);

}



