#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Discussion
----------
A symbol should be identified as a "delimiter" if and only if it is correctly
paired with its complement; and delimiters should also be properly nested to be
recognised as such. However, the Task requirements -- in particular Example 1
-- clearly specify that symbols are to be recognised as delimiters regardless
of appropriate pairing. (In Example 1, the substring "Apple ][+" contains a
closing delimiter *followed by* its opening complement.) Since this is the Task
as given, it is what has been implemented in the solution below.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $USAGE =>
"Usage:
  perl $0 <delims> <search>

    <delims>    A string of delimiter pairs
    <search>    A string to search\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 131, Task #2: Find Pairs (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($delims, $search) = parse_command_line();

    print "Input:\n";
    print "    Delimiter pairs: $delims\n";
    print "    Search string:   $search\n\n";

    my (%open_chars, %clse_chars);
    my  $i = 0;

    for my $delim (split '', $delims)
    {
        (++$i % 2 == 1) ? ++$open_chars{ $delim }
                        : ++$clse_chars{ $delim };
    }

    my $open_str = '';
    my $clse_str = '';

    for my $char (split '', $search)
    {
        $open_str .= $char if exists $open_chars{ $char };
        $clse_str .= $char if exists $clse_chars{ $char };
    }

    print "Output:\n";
    print "    $open_str\n";
    print "    $clse_str\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2
            or error( "Expected 2 command line arguments, found $args" );

    my ($delims, $search) = @ARGV;

    length( $delims ) % 2 == 0
            or error( "The delimiter string $delims contains an odd number " .
                       'of characters' );

    return ($delims, $search);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
