use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 239
=========================

TASK #1
-------
*Same String*

Submitted by: Mohammad S Anwar

You are given two arrays of strings.

Write a script to find out if the word created by concatenating the array
elements is the same.

Example 1

  Input: @arr1 = ("ab", "c")
         @arr2 = ("a", "bc")
  Output: true

  Using @arr1, word1 => "ab" . "c" => "abc"
  Using @arr2, word2 => "a" . "bc" => "abc"

Example 2

  Input: @arr1 = ("ab", "c")
         @arr2 = ("ac", "b")
  Output: false

  Using @arr1, word1 => "ab" . "c" => "abc"
  Using @arr2, word2 => "ac" . "b" => "acb"

Example 3

  Input: @arr1 = ("ab", "cd", "e")
         @arr2 = ("abcde")
  Output: true

  Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
  Using @arr2, word2 => "abcde"

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Concatenation may be performed ONLY in array order.
2. An empty array concatenates to the empty string.
3. The SEPARATOR string is never used as an array element.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If VERBOSE is set to True (the default), the output ("True" or "False") is
   followed by details of the two concatenated strings.

=end comment
#===============================================================================

use Test;

my Str  constant SEPARATOR = '*';
my Bool constant VERBOSE   = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 239, Task #1: Same String (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| Two lists of strings, separated by the token "*"

    *@strings where { .all ~~ Str:D && .one eq SEPARATOR }
)
#===============================================================================
{
    my Array[Str] ($array1, $array2) = parse-input( @strings );

    "Input:  \@array1 = (%s)\n".printf: $array1.map( { qq["$_"] } ).join: ', ';
    "        \@array2 = (%s)\n".printf: $array2.map( { qq["$_"] } ).join: ', ';

    my (Bool $same, Str $word1, Str $word2) = same-string( $array1, $array2 );

    "Output: %s\n".printf: $same ?? 'True' !! 'False';

    show-strings( $array1, $word1, $array2, $word2 ) if VERBOSE;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub same-string
(
    List:D[Str:D] $array1,
    List:D[Str:D] $array2
--> List:D[Bool:D, Str:D, Str:D]
)
#-------------------------------------------------------------------------------
{
    my Str $word1 = $array1.join: '';
    my Str $word2 = $array2.join: '';

    return $word1 eq $word2, $word1, $word2;
}

#-------------------------------------------------------------------------------
sub parse-input( List:D[Str:D] $strs --> List:D[List:D[Str:D], List:D[Str:D]] )
#-------------------------------------------------------------------------------
{
    my Str (@array1, @array2);
    my Bool $second = False;

    for @$strs -> Str $s
    {
        if    $second
        {
            @array2.push: $s;
        }
        elsif $s eq SEPARATOR
        {
            $second = True;
        }
        else
        {
            @array1.push: $s;
        }
    }

    return @array1, @array2;
}

#-------------------------------------------------------------------------------
sub show-strings( List:D[Str:D] $array1, Str:D $word1,
                  List:D[Str:D] $array2, Str:D $word2 )
#-------------------------------------------------------------------------------
{
    put();

    if $array1.elems > 1
    {
        qq[Using \@array1, word1 => %s => "%s"\n].printf:
            $array1.map( { qq["$_"] } ).join( ' . ' ), $word1;
    }
    else
    {
        qq[Using \@array1, word1 => "$word1"].put;
    }

    if $array2.elems > 1
    {
        qq[Using \@array2, word2 => %s => "%s"\n].printf:
            $array2.map( { qq["$_"] } ).join( ' . ' ), $word2;
    }
    else
    {
        qq[Using \@array2, word2 => "$word2"].put;
    }
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test, $arr1str, $arr2str, $exp-same, $exp-word1, $exp-word2) =
            $line.split: / \| /;

        for     $test, $arr1str, $arr2str, $exp-same, $exp-word1, $exp-word2
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str @arr1 = $arr1str.split: / \s+ /, :skip-empty;
        my Str @arr2 = $arr2str.split: / \s+ /, :skip-empty;

        my (Bool $same, Str $word1, Str $word2) = same-string( @arr1, @arr2 );

        my $same-str = $same ?? 'True' !! 'False';

        is $same-str, $exp-same,  $test ~ ': same';
        is $word1,    $exp-word1, $test ~ ': word1';
        is $word2,    $exp-word2, $test ~ ': word2';
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
        Example 1|ab c   |a bc |True |abc  |abc
        Example 2|ab c   |ac b |False|abc  |acb
        Example 3|ab cd e|abcde|True |abcde|abcde
        END
}

################################################################################
