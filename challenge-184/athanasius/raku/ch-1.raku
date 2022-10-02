use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 184
=========================

TASK #1
-------
*Sequence Number*

Submitted by: Mohammad S Anwar

You are given list of strings in the format aa9999 i.e. first 2 characters can
be anything 'a-z' followed by 4 digits '0-9'.

Write a script to replace the first two characters with sequence starting with
'00', '01', '02' etc.

Example 1

  Input: @list = ( 'ab1234', 'cd5678', 'ef1342')
  Output: ('001234', '015678', '021342')

Example 2

  Input: @list = ( 'pq1122', 'rs3334')
  Output: ('001122', '013334')

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
1. From the wording of the question combined with the two Examples, I assume
   that sequence numbers are to be assigned in the order in which strings
   appear in the input list, regardless of the contents of theie 2-letter pre-
   fixes.
2. If more than 100 strings are given as input, the prefixes simply increment
   to 3 digits.

Interface
---------
If no arguments are given on the command line, the test suite is run.

Implementation
--------------
Uses Raku's built-in (postfix) ++ operator, which "[i]ncrements its argument by
one and returns the original value." [1] The increment is performed by the
built-in method succ(), which, given a string, "searches for the last alpha-
numeric sequence that is not preceded by a dot, and increments it." [2]

References
----------
[1] https://docs.raku.org/language/operators#index-entry-postfix_++-++
[2] https://docs.raku.org/routine/succ

=end comment
#==============================================================================

use Test;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 184, Task #1: Sequence Number (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| List of strings, format $$#### where $ is a-z, # is 0-9

    *@list where { .all ~~ / ^ <[ a .. z ]> ** 2 <[ 0 .. 9 ]> ** 4 $ / }
)
#==============================================================================
{
    "Input: @list = ( %s )\n".printf: format-list(          @list   );
    "Output:        ( %s )\n".printf: format-list( replace( @list ) );
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str  $test             = $line.chomp;
        my Str ($name, $in, $exp) = $test.split: / \, \s* /, 3, :skip-empty;

        is replace( $in.split( / \s+ / ).list ), $exp, $name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub replace( List:D[Str:D] $list --> List:D[Str:D] )
#------------------------------------------------------------------------------
{
    my Str @replaced;
    my Str $prefix = '00';

    for @$list -> Str $string
    {
        @replaced.push: $prefix++ ~ $string.substr: 2 .. 5;
    }

    return @replaced;
}

#------------------------------------------------------------------------------
sub format-list( List:D[Str:D] $list --> Str:D )
#------------------------------------------------------------------------------
{
    return $list.map( { "'$_'" } ).join: ', ';
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1,    ab1234 cd5678 ef1342, 001234 015678 021342
        Example 2,    pq1122 rs3334,        001122 013334
        Same nums,    zz9876 yy9876 xx9876, 009876 019876 029876
        Same letters, aa2468 aa3579 aa1680, 002468 013579 021680
        END
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
