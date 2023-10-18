use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 239
=========================

TASK #2
-------
*Consistent Strings*

Submitted by: Mohammad S Anwar

You are given an array of strings and allowed string having distinct characters.

    A string is consistent if all characters in the string appear in the string
    allowed.

Write a script to return the number of consistent strings in the given array.

Example 1

  Input: @str = ("ad", "bd", "aaab", "baa", "badab")
         $allowed = "ab"
  Output: 2

  Strings "aaab" and "baa" are consistent since they only contain characters 'a'
  and 'b'.

Example 2

  Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
         $allowed = "abc"
  Output: 7

Example 3

  Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
         $allowed = "cad"
  Output: 4

  Strings "cc", "acd", "ac", and "d" are consistent.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If CASE-SENSITIVE is set to False (the default), an "a" in the allowed string
   matches both "a" and "A" in any string in the input list. If CASE-INSENSITIVE
   is set to True, the case must also match.
3. If VERBOSE is set to True (the default), the output (i.e., the count of con-
   sistent strings) is followed by a list of the consistent strings found (if
   any).

=end comment
#===============================================================================

use Test;

my Bool constant CASE-SENSITIVE = False;
my Bool constant VERBOSE        = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 239, Task #2: Consistent Strings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D :$allowed,                   #= Non-empty string of allowed characters
          *@strings where { .all ~~ Str:D }                   #= List of strings
)
#===============================================================================
{
    qq[Input:  \@strings = (%s)\n].printf: format-as-list( @strings );
    qq[        \$allowed =  "$allowed"].put;

    my Str  @con-strs = find-consistent-strings( @strings, $allowed );
    my UInt $count    = @con-strs.elems;

    "Output: $count".put;

    if VERBOSE && $count > 0
    {
        "\nConsistent strings: %s\n".printf: format-as-list( @con-strs );
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-consistent-strings
(
    List:D[Str:D] $strings,
           Str:D  $allowed
--> List:D[Str:D]
)
#-------------------------------------------------------------------------------
{
    my     Str  @consistent-strings;
    my Set[Str] $allowed-chars = Set[Str].new:
                    $allowed.split( '', :skip-empty ).map:
                        { CASE-SENSITIVE ?? $_ !! |(.lc, .uc) };

    for @$strings -> Str $string
    {
        my Set[Str] $characters = Set[Str].new: $string.split: '', :skip-empty;

        @consistent-strings.push: $string if $characters ⊆ $allowed-chars;
    }

    return @consistent-strings;
}

#-------------------------------------------------------------------------------
sub format-as-list( List:D[Str:D] $strings --> Str:D )
#-------------------------------------------------------------------------------
{
    return $strings.map( { qq["$_"] } ).join: ', ';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $strings, $allowed, $exp-count, $exp-con-strs) =
            $line.split: / \| /;

        for     $test-name, $strings, $allowed, $exp-count, $exp-con-strs
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @strings      = $strings\    .split: / \s+ /;
        my Str @exp-con-strs = $exp-con-strs.split: / \s+ /;
        my Str @con-strs     = find-consistent-strings( @strings, $allowed );

        is        @con-strs.elems, $exp-count.Int, $test-name ~ ': count';
        is-deeply @con-strs,       @exp-con-strs,  $test-name ~
                                                         ': consistent strings';
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
        Example 1|ad bd aaab baa badab    |ab |2|aaab baa
        Example 2|a b c ab ac bc abc      |abc|7|a b c ab ac bc abc
        Example 3|cc acd b ba bac bad ac d|cad|4|cc acd ac d
        END
}

################################################################################
