#!/usr/bin/perl

use strict;
use warnings;
use English;

use Text::Wrap;

################################################################################
# Begin main execution
################################################################################

$Text::Wrap::columns = 64;

my $text = "    All he could think about was how it would all end. There was
    still a bit of uncertainty in the equation, but the basics
    were there for anyone to see. No matter how much he tried to
    see the positive, it wasn't anywhere to be seen. The end was
    coming and it wasn't going to be pretty.";

print("\n");
print("Input:\n", $text, "\n");
print("\n");
print(
    "Output:\n",
    wrap("    ", "    ", sort_paragraph_words($text)),
    "\n"
);
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Sort the words within each sentence of a paragraph, in ascending
# alphanumeric, case-insensitive order
# Takes one argument:
# * The paragraph to sort, which must consist of a single text string, but
#   within that string may be word-wrapped onto multiple lines
# Returns:
# * The paragraph with each sentence's words sorted in ascending order; the
#   text will be presented as one line, WITHOUT a trailing newline character
################################################################################
sub sort_paragraph_words{
    my $paragraph = shift();

    # Massage the input text a bit:
    # * Replace all sequences of whitespace with single
    #   spaces
    # * Strip trailing whitespace
    # * Strip trailing period
    # * Strip leading whitespace
    $paragraph =~ s/\s+/ /g;
    $paragraph =~ s/\s$//;
    $paragraph =~ s/\.$//;
    $paragraph =~ s/^\s//;

    # Do things and return...
    return(
        # Rejoin the sentences into a paragraph
        join(
            ". ",
            map(
                # Rejoin the words into a sentence
                join(
                    " ",
                    # Sort the words, case-insensitively
                    sort(
                        { lc($a) cmp lc($b) }

                        # Split a sentence into words
                        split(/ /, $_)
                    )
                ),

                # Split the paragraph into sentences
                split(/\. /, $paragraph)
            )
        )

        # Add a trailing period
        .
        "."
    );

}



