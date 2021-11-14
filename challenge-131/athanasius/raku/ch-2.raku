use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 131
=========================

TASK #2
-------
*Find Pairs*

Submitted by: Yary

You are given a string of delimiter pairs and a string to search.

Write a script to return two strings, the first with any characters matching
the "opening character" set, the second with any matching the "closing char-
acter" set.

Example 1:

 Input:
    Delimiter pairs: ""[]()
    Search String: "I like (parens) and the Apple ][+" they said.

 Output:
    "(["
    ")]"

Example 2:

 Input:
    Delimiter pairs: **//<>
    Search String: /* This is a comment (in some languages) */ <could be a tag>

 Output:
    /**/<
    /**/>

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Discussion
----------
A symbol should be identified as a "delimiter" if and only if it is correctly
paired with its complement; and delimiters should also be properly nested to be
recognised as such. However, the Task requirements -- in particular Example 1
-- clearly specify that symbols are to be recognised as delimiters regardless
of appropriate pairing. (In Example 1, the substring "Apple ][+" contains a
closing delimiter *followed by* its opening complement.) Since this is the Task
as given, it is what has been implemented in the solution below.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 131, Task #2: Find Pairs (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D $delims where { .chars % 2 == 0 },     #= A string of delimiter pairs
    Str:D $search                                #= A string to search
)
#==============================================================================
{
    'Input:'.put;
    "    Delimiter pairs: $delims".put;
    "    Search string:   $search\n".put;

    my Str (@open-chars, @clse-chars);
    my UInt $i = 0;

    for $delims.split: '', :skip-empty -> Str $delim
    {
        ( ++$i % 2 == 1 ?? @open-chars !! @clse-chars ).push: $delim;
    }

    my Set[Str] $open-set = Set[Str].new: @open-chars;
    my Set[Str] $clse-set = Set[Str].new: @clse-chars;
    my Str      $open-str = '';
    my Str      $clse-str = '';

    for $search.split: '', :skip-empty -> Str $char
    {
        $open-str ~= $char if $char ∈ $open-set;
        $clse-str ~= $char if $char ∈ $clse-set;
    }

    'Output:'.put;
    "    $open-str".put;
    "    $clse-str".put;
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
