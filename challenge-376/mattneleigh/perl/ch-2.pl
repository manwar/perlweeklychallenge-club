#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing.",


    "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words.",


    "to make a word bold: '...it is <B>very</B> very important...'.",


    "Perl officially stands for Practical Extraction and Report Language, except when it doesn't.",


    "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n\n",
        $string,
        bracket_doubled_words($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, which may contain embedded newlines but will not contain
# square brackets ( [ or ] ), place brackets around each word within a pair of
# doubled words (such as "this this").  This matching of paired words may take
# place across newlines and other forms of whitespace, and certain non-
# whitespace characters including punctuation and HTML tags.  Only lines of
# text to which brackets have been applied will be returned; matching of paired
# words is not case sensitive.
# Takes one argument:
# * The string to examine (e.g. "There's more than one one way to do it.")
# Returns:
# * A string containing those lines from the original to which brackets have
#   been applied, according to the procedure specified above, or an empty
#   string if no brackets have been applied
#   (e.g. "There's more than [one] [one] way to do it.")
################################################################################
sub bracket_doubled_words{
    my $string = shift();

    # Apply a pattern to the string, case
    # insensitively and globally putting brackets
    # around qualifying matched words
    $string =~ s/(?<=^|\W)(\w+)(\W+|\W*<\/?\w+>\W*)(\1)(?=\W|$)/[$1]$2\[$3\]/ig;

    return(
        # Split the modified text into lines, and
        # construct a newline-delimited string that
        # only contains lines to which brackets have
        # been added
        join("\n", map($_ =~ m/\[.*]/ ? $_ : (), split(/\n/, $string)))
    );

}



