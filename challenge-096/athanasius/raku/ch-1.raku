use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 096
=========================

Task #1
-------
*Reverse Words*

Submitted by: Mohammad S Anwar

You are given a string $S.

Write a script to reverse the order of words in the given string. The string
may contain leading/trailing spaces. The string may have more than one space
between words in the string. Print the result without leading/trailing spaces
and there should be only one space between words.

Example 1:

 Input: $S = "The Weekly Challenge"
 Output: "Challenge Weekly The"

Example 2:

 Input: $S = "    Perl and   Raku are  part of the same family  "
 Output: "family same the of part are Raku and Perl"

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
- "Spaces" include all whitespace characters.
-  Any punctuation attached to a word is to be considered a part of that word,
   e.g., "Fred and Wilma, Barney and Betty" becomes
         "Betty and Barney Wilma, and Fred"
   with the comma still attached to "Wilma" as in the original string.

Implementation
--------------
Split the string on whitespace, reverse the result, and re-join the reversed
list of words into a single string using single spaces.

Note: The named parameter ":skip-empty" ensures that split() "do[es] not return
empty strings before or after a delimiter" (https://docs.raku.org/routine/
split), thereby removing leading and trailing whitespace.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 096, Task #1: Reverse Words (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $S        #= A single string containing words separated by whitespace
)
#==============================================================================
{
    qq[Input:  "%s"\n].printf: $S;
    qq[Output: "%s"\n].printf: $S.split(/\s+/, :skip-empty).reverse.join: ' ';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
