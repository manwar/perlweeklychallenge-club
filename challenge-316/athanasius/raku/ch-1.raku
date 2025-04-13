use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 316
=========================

TASK #1
-------
*Circular*

Submitted by: Mohammad Sajid Anwar

You are given a list of words.

Write a script to find out whether the last character of each word is the first
character of the following word.

Example 1

  Input: @list = ("perl", "loves", "scala")
  Output: true

Example 2

  Input: @list = ("love", "the", "programming")
  Output: false

Example 3

  Input: @list = ("java", "awk", "kotlin", "node.js")
  Output: true

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If matching is to be case-INsensitive, the flag "-i" is entered on the
   command-line; then:
3. A non-empty list of words is entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 316, Task #1: Circular (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Bool :i($case-insensitive) = False,     #= Comparisons are case-insensitive?
    *@list where { .elems > 0 },            #= A non-empty list of words
)
#===============================================================================
{
    "Input:  \@list = (%s)\n".printf: @list.map( { qq["$_"] } ).join: ', ';
    "        (Comparisons %s case-sensitive)\n".printf:
                    $case-insensitive ?? 'are NOT' !! 'ARE';

    my Bool $result = solve( @list, !$case-insensitive );

    "Output: %s\n".printf: $result ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub solve( List:D[Str:D] $list, Bool:D $case-sensitive = True --> Bool:D )
#-------------------------------------------------------------------------------
{
    return True if $list.elems < 2;

    for 0 .. $list.end - 1 -> UInt $i
    {
        my Str $first = $list[ $i + 1 ]\    .substr: 0, 1;
        my Str $last  = $list[ $i     ].flip.substr: 0, 1;

        return False unless $case-sensitive ?? $first    eq $last 
                                            !! $first.lc eq $last.lc;
    }

    return True;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $case-sensitive-str, $list-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $case-sensitive-str, $list-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Bool $sensitive = $case-sensitive-str eq 'Y';
        my Str  @list      = $list-str.split: / \s+ /, :skip-empty;
        my Bool $result    = solve( @list, $sensitive );
        my Bool $expected  = $expected-str eq 'true';

        is $result, $expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|Y|perl loves scala       |true
        Example 2|Y|love the programming   |false
        Example 3|Y|java awk kotlin node.js|true
        Case 1   |Y|Snap Perl Linux X x    |false
        Case 2   |N|Snap Perl Linux X x    |true
        END
}

################################################################################
