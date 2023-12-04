use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 245
=========================

TASK #1
-------
*Sort Language*

Submitted by: Mohammad S Anwar

You are given two array of languages and its popularity.

Write a script to sort the language based on popularity.

Example 1

  Input: @lang = ('perl', 'c', 'python')
         @popularity = (2, 1, 3)
  Output: ('c', 'perl', 'python')

Example 2

  Input: @lang = ('c++', 'haskell', 'java')
         @popularity = (1, 3, 2)
  Output: ('c++', 'java', 'haskell')

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
2. Language names are entered as a single, whitespace-separated string named
   "lang", for example:  --lang="c++ haskell java"
3. Popularity ratings are entered as a list of unsigned integers. The number of
   popularity ratings must equal the number of language names. Duplicate popu-
   larity ratings are allowed: languages with identical popularities are sorted
   in alphabetical order.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 245, Task #1: Sort Language (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A whitespace-separated list of language names

    Str :$lang,

    #| A list of popularity ratings for the given languages

        *@popularity where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    my Str @languages = $lang.split: / \s+ /, :skip-empty;

    @languages.elems == @popularity.elems
        or error( 'The input lists have different sizes' );

    "Input: \@languages  = (%s)\n".printf:  format-langs( @languages );
    "       \@popularity = (%s)\n".printf:  @popularity.join: ', ';

    my Str @sorted = sort-languages( @languages, @popularity );

    "Output:              (%s)\n"\.printf:  format-langs( @sorted );
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub sort-languages
(
    List:D[Str:D]  $languages,
    List:D[UInt:D] $popularity where { .elems == $languages.elems }
--> List:D[Str:D]
)
#-------------------------------------------------------------------------------
{
    my UInt %dict{Str} = @$languages Z=> $popularity.map: { .Int };
    my Str  @sorted    = $languages.sort:
            {                                           # Sort (ascending) by:
                %dict{ $^a } <=> %dict{ $^b } ||        # 1. popularity; then
                       $^a   leg        $^b             # 2. alphabetical order
            };

    return @sorted;
}

#-------------------------------------------------------------------------------
sub format-langs( List:D[Str:D] $languages --> Str:D )
#-------------------------------------------------------------------------------
{
    return $languages.map( { "'$_'" } ).join: ', ';
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $languages-str, $popularity-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $languages-str, $popularity-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str  @languages  = $languages-str\.split( / \s+ / );
        my UInt @popularity = $popularity-str.split( / \s+ / ).map: { .Int };
        my Str  @expected   = $expected-str\ .split( / \s+ / );
        my Str  @sorted     = sort-languages( @languages, @popularity );

        is-deeply @sorted, @expected, $test-name;
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
        Example 1|perl c python   |2 1 3|c perl python
        Example 2|c++ haskell java|1 3 2|c++ java haskell
        END
}

################################################################################
