use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 186
=========================

TASK #1
-------
*Zip List*

Submitted by: Mohammad S Anwar

You are given two list @a and @b of same size.

Create a subroutine sub zip(@a, @b) that merge the two list as shown in the
example below.

Example

  Input:  @a = qw/1 2 3/; @b = qw/a b c/;
  Output: zip(@a, @b) should return qw/1 a 2 b 3 c/;
          zip(@b, @a) should return qw/a 1 b 2 c 3/;

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
If no arguments are given on the command-line, the test suite is run.

=end comment
#==============================================================================

use Test;

my UInt constant $TEST-FIELDS = 4;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 186, Task #1: Zip List (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| String representing @a, with list elements separated by whitespace
    Str:D $a,

    #| String representing @b, with list elements separated by whitespace
    Str:D $b
)
#==============================================================================
{
    my Str @a = $a.split: / \s+ /, :skip-empty;
    my Str @b = $b.split: / \s+ /, :skip-empty;

    "Input:  @a = (%s); @b = (%s)\n".printf: @a.join( ', ' ), @b.join( ', ' );

    "Output: zip(@a, @b) = (%s)\n".printf: zip( @a, @b ).join: ', ';
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($name, $in1, $in2, $exp) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        my Str @a   = $in1.split: / \s+ /, :skip-empty;
        my Str @b   = $in2.split: / \s+ /, :skip-empty;
        my Str $out = zip( @a, @b ).join: ' ';
        
        is $out, $exp, $name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub zip( List:D[Str:D] $a, List:D[Str:D] $b --> List:D[Str:D] )
#------------------------------------------------------------------------------
{
    my Str @zipped;

    for 0 .. $a.end -> UInt $i
    {
        @zipped.push: $a[ $i ], $b[ $i ];
    }

    return @zipped;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
Example 1, 1 2 3,               a b c,        1 a 2 b 3 c
Example 2, a b c,               1 2 3,        a 1 b 2 c 3
Odd/even,  1 3 5 7 9,           2 4 6 8 10,   1 2 3 4 5 6 7 8 9 10
Sentence,  There's than way do, more 1 to it, There's more than 1 way to do it
END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR:  $message".put;

    USAGE();

    exit 0;
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
