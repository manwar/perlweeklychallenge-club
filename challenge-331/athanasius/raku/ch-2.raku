use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 331
=========================

TASK #2
-------
*Buddy Strings*

Submitted by: Mohammad Sajid Anwar

You are given two strings, source and target.

Write a script to find out if the given strings are Buddy Strings.

  If swapping of a letter in one string make them same as the other then they
  are `Buddy Strings`.

Example 1

  Input: $source = "fuck"
         $target = "fcuk"
  Output: true

  The swapping of 'u' with 'c' makes it buddy strings.

Example 2

  Input: $source = "love"
         $target = "love"
  Output: false

Example 3

  Input: $source = "fodo"
         $target = "food"
  Output: true

Example 4

  Input: $source = "feed"
         $target = "feed"
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
2. Two strings are entered on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 331, Task #2: Buddy Strings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $source,                       #= First  string
    Str:D $target                        #= Second string
)
#===============================================================================
{
    qq[Input:  \$source = "$source"].put;
    qq[        \$target = "$target"].put;

    my Bool $buddies = are-buddies( $source, $target );

    "Output: %s\n".printf: $buddies ?? 'true' !! 'false';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub are-buddies( Str:D $source, Str:D $target --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Bool $result = False;

    if same-chars( $source, $target )
    {
        my UInt $diffs = count-diffs( $source, $target );

        $result = $diffs == 0 ?? has-duplicates( $source ) !!
                  $diffs == 2;
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub same-chars( Str:D $source, Str:D $target --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Bool $result = False;

    if $source.chars == $target.chars
    {
        my Str $source-norm = $source.split( '', :skip-empty ).sort.join;
        my Str $target-norm = $target.split( '', :skip-empty ).sort.join;

        $result = $source-norm eq $target-norm;
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub count-diffs
(
    Str:D $source,
    Str:D $target where { .chars == $source.chars }
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    my Str  @source-chars = $source.split: '', :skip-empty;
    my Str  @target-chars = $target.split: '', :skip-empty;
    my UInt $differences  = 0;

    for 0 .. @source-chars.end -> UInt $i
    {
        ++$differences if @source-chars[ $i ] ne @target-chars[ $i ];
    }

    return $differences;
}

#-------------------------------------------------------------------------------
sub has-duplicates( Str:D $str --> Bool:D )
#-------------------------------------------------------------------------------
{
    my Bool $result = False;
    my UInt %char-count;
          ++%char-count{ $_ } for $str.split: '', :skip-empty;

    for %char-count.values -> UInt $count
    {
        if $count > 1
        {
            $result = True;
            last;
        }
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $source, $target, $expected) = $line.split: / \| /;

        for     $test-name, $source, $target, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str $buddies = are-buddies( $source, $target ) ?? 'true' !! 'false';

        is $buddies, $expected, $test-name;
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
        Example 1   |fuck|fcuk |true
        Example 2   |love|love |false
        Example 3   |fodo|food |true
        Example 4   |feed|feed |true
        Diff lengths|Perl|Pearl|false
        END
}

################################################################################
