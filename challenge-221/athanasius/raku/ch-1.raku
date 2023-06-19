use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 221
=========================

TASK #1
-------
*Good Strings*

Submitted by: Mohammad S Anwar

You are given a list of @words and a string $chars.

    A string is good if it can be formed by characters from $chars, each char-
    acter can be used only once.

Write a script to return the sum of lengths of all good strings in words.

Example 1

  Input: @words = ("cat", "bt", "hat", "tree")
         $chars = "atach"
  Output: 6

  The good strings that can be formed are "cat" and "hat" so the answer is
  3 + 3 = 6.

Example 2

  Input: @words = ("hello", "world", "challenge")
         $chars = "welldonehopper"
  Output: 10

  The strings that can be formed are "hello" and "world" so the answer is
  5 + 5 = 10.

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
2. If $CASE-SENSITIVE is set to False (the default), upper- and lower-case
   versions of the same letter (e.g., "A" and "a") are treated as equivalent;
   otherwise, they are treated as different characters.
3. If $VERBOSE is set to True (the default), the output is followed by a list of
   the "good strings".

=end comment
#===============================================================================

use Test;

my Bool constant $CASE-SENSITIVE = False;
my Bool constant $VERBOSE        = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 221, Task #1: Good Strings (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Str:D $chars,                                      #= A string of characters

    *@words where { .elems > 0 && .all.chars > 0 }     #= A non-empty list of
                                                       #=   non-empty strings
)
#===============================================================================
{
    qq[Input:  \@words = (%s)\n].printf: @words.map( { qq["$_"] } ).join: ', ';
    qq[        \$chars =  "$chars"].put;

    my Str  @strings = find-good-strings( @words, $chars );
    my UInt $sum     = find-total-length( @strings );

    "Output: $sum".put;

    if $VERBOSE && @strings.elems > 0
    {
        if @strings.elems == 1
        {
            qq[\nThe good string is "{ @strings[ 0 ] }"].put;
        }
        else
        {
            qq[\nThe good strings are %s\n].printf:
                @strings.map( { qq["$_"] } ).join: ', ';
        }
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-good-strings( List:D[Str:D] $words, Str:D $chars --> List:D[Str:D] )
#-------------------------------------------------------------------------------
{
    my Str      @chars = $chars.split: '';
                @chars.= map: { .lc } unless $CASE-SENSITIVE;
    my Bag[Str] $pool  = Bag[Str].new: @chars;
    my Str      @good-strings;

    for @$words -> Str $word
    {
        my Str      @letters = $word.split: '';
                    @letters.= map: { .lc } unless $CASE-SENSITIVE;
        my Bag[Str] $target  = Bag[Str].new: @letters;

        @good-strings.push: $word if $target ⊆ $pool;   # ⊆ "improper subset of"
    }

    return @good-strings;
}

#-------------------------------------------------------------------------------
sub find-total-length( List:D[Str:D] $strings --> UInt:D )
#-------------------------------------------------------------------------------
{
    return [+] $strings.map: { .chars };
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($name, $chars, $words, $exp-sum, $exp-words) =
                $line.split: / \| /;

        for $name, $chars, $words, $exp-sum, $exp-words        # Trim whitespace
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @expected = $exp-words.split: / \s+ /;
        my Str  @words    = $words.split:     / \s+ /;
        my Str  @strings  = find-good-strings( @words, $chars );
        my UInt $sum      = find-total-length( @strings );

        is        $sum,     $exp-sum.Int, $name;
        is-deeply @strings, @expected,    $name if $VERBOSE;
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
        Example 1|atach         |cat bt hat tree      | 6|cat hat
        Example 2|welldonehopper|hello world challenge|10|hello world
        END
}

################################################################################
