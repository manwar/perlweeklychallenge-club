use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 083
=========================

Task #1
-------
*Words Length*

Submitted by: Mohammad S Anwar

You are given a string $S with 3 or more words.

Write a script to find the length of the string except the first and last words
ignoring whitespace.

Example 1:

 Input: $S = "The Weekly Challenge"

 Output: 6

Example 2:

 Input: $S = "The purpose of our lives is to be happy"

 Output: 23

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 083, Task #1: Words Length (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    Str:D $S         #= A single string containing 3 or more words separated by
                     #= whitespace
)
##=============================================================================
{
    my Str @words = $S.split: /\s+/, :skip-empty;

    @words.elems >= 3            or error('Too few words in the input string');

    qq[Input: \$S = "$S"\n].put;

    my UInt $length  = 0;
            $length += .chars for @words[1 .. *-2];

    "Output: $length".put;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;
    USAGE();

    exit 1;
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
