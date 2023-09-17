#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @word_lists = (
    [ "java", "javascript", "julia" ],
    [ "bella", "label", "roller" ],
    [ "cool", "lock", "cook" ]
);

print("\n");
foreach my $word_list (@word_lists){
    printf(
        "Input: \@word_list = (%s)\nOutput: (%s)\n\n",
        join(", ", map("\"". $_ . "\"", @{$word_list})),
        join(", ",
            map(
                "\"". $_ . "\"",
                find_omnipresent_and_repeated_letters(@{$word_list})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine which letters are present in all of the words in a list, with each
# such letter repeated the minimum number of times it's duplicated within each
# word
# Takes one argument:
# * The list of words to examine (e.g. ( "bella", "label", "roller" ) )
# Returns:
# * A list of omnipresent (and possibly duplicated) letters (e.g. ( "e", "l",
#   "l" ) )
# NOTE: The order in which letters appear in the returned list is dictated by
# their order in the first word in the input list
################################################################################
sub find_omnipresent_and_repeated_letters{

    my @letters;
    my %table;

    # Build a letter frequency list for the first
    # word, preserving the order of letters therein
    foreach my $letter (split('', lc(shift()))){
        if(defined($table{$letter})){
            # Letter seen before- increment its count,
            # looking up its array index from the letter
            # table
            $letters[$table{$letter}][1]++;
        } else{
            # Letter not seen before- start its count
            # and store its index in the letter table
            push(@letters, [ $letter, 1 ]);
            $table{$letter} = $#letters;
        }
    }

    # Loop over remaining words
    while(@ARG){
        my $i = 0;

        # Build a new letter frequency table for this word
        %table = ();
        foreach my $letter (split('', lc(shift()))){
            if($table{$letter}){
                # Letter seen before- increment its count
                $table{$letter}++;
            } else{
                # Letter not seen before- start its count
                $table{$letter} = 1;
            }
        }

        # Loop over duplicate letters from
        # previous words
        while($i <= $#letters){
            if($table{$letters[$i][0]}){
                # Letter is present in the new word...
                if($table{$letters[$i][0]} < $letters[$i][1]){
                    # ...and its frequency count is LESS than in
                    # any previously seen word- store the new
                    # count and then...
                    $letters[$i][1] = $table{$letters[$i][0]};
                }
                # ...move on to the next letter
                $i++;
            } else{
                # Letter isn't present in the new word-
                # delete it
                splice(@letters, $i, 1);
            }
        }
    }

    return(
        # Loop over remaining letters that were seen
        # in every word...
        map(
            {
                my $ref = $_;

                # ...and repeat each letter the minimum number
                # of times it was seen in any particular word
                map($ref->[0], (1 .. $ref->[1]));
            }
            @letters
        )
    );

}



