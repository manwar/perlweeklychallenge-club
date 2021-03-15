use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 094
=========================

Task #1
-------
*Group Anagrams*

Submitted by: Mohammad S Anwar

You are given an array of strings @S.

Write a script to group *Anagrams* together in any random order.

    An anagram is a word or phrase formed by rearranging the letters of a
    different word or phrase, typically using all the original letters exactly
    once.

Example 1:

        Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
        Output: [ ("bat", "tab"),
                  ("saw", "was"),
                  ("top", "pot", "opt") ]

Example 2:

        Input: ("x")
        Output: [ ("x") ]

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Input "words" are simply sequences of characters separated by whitespace on the
command line. Except for the purpose of grouping, the case of all input letters
is preserved. If no command-line arguments are given, the script runs pre-set
tests to verify correct operation.

Although the Task description specifies that anagrams are to be grouped togeth-
er "in any random order", this script observes a strict ordering to facilitate
testing:
  (1) Groups are ordered alphabetically by key, where each key is an ordered
      sequence of the letters (if necessary, converted to lower case) from
      which the anagrams in that group are formed. (Note that the key of an
      anagram group is not necessarily itself a word in that group.)
  (2) Within each anagram group, words are ordered alphabetically, with upper
      case 'Z' coming before lower case 'a'.

If the input contains repeated words, these are retained when the input is
displayed but silently removed in the output.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 094, Task #1: Group Anagrams (Raku)\n".put;
}

#==============================================================================
sub MAIN( *@S )
#==============================================================================
{
    if @S.elems > 0
    {
        "Input: ({ @S.map( { qq["$_"] } ).join: ', ' })".put;

        "Output: { group-anagrams( @S ) }".put;
    }
    else
    {
        test;
    }
}

#------------------------------------------------------------------------------
sub group-anagrams( Array:D[Str:D] $S --> Str:D )
#------------------------------------------------------------------------------
{
    my Array[Str] %anagrams;

    for @$S -> Str $string
    {
        my Str $key = $string.lc.split('').sort.join;

        if %anagrams{ $key }:exists
        {
            my Bool $found = False;

            for %anagrams{ $key }.list -> Str $anagram
            {
                if $anagram eq $string
                {
                    $found = True;
                    last;
                }
            }

            %anagrams{ $key }.push: $string unless $found;
        }
        else
        {
            %anagrams{ $key } = Array[Str].new( $string );
        }
    }

    return format-output( %anagrams );
}

#------------------------------------------------------------------------------
sub format-output( Hash:D[ Array:D[Str:D] ] $anagrams --> Str:D )
#------------------------------------------------------------------------------
{
    my Str  $output = '[ ';
    my Bool $first  = True;

    for %$anagrams.keys.sort -> Str $key
    {
        $output ~= ",\n          " unless $first;
        $first   = False;
        $output ~= '(';
        $output ~= $anagrams{ $key }.sort.map( { qq["$_"] } ).join: ', ';
        $output ~= ')';
    }
 
    $output ~= ' ]';

    return $output;
}

#------------------------------------------------------------------------------
sub test()
#------------------------------------------------------------------------------
{
    use Test;
    plan 3;

    like\
    (
        group-anagrams( [ < opt bat saw tab pot top was > ] ),
        rx{
            ^ \[                           \s
                   '("bat", "tab"),'       \s+
                   '("saw", "was"),'       \s+
                   '("opt", "pot", "top")' \s
              \] $
          },
        'Example 1'
    );

    like\
    (
        group-anagrams( [ 'x' ] ),
        rx{
            ^ \[           \s
                   '("x")' \s
              \] $
          },
        'Example 2'
    );

    like\
    (
        group-anagrams( [ 'Radium came', 'restful', 'eleven plus two',
                          'silent', 'October Sky', 'listen', 'Madam Curie',
                          'fluster', 'Rocket Boys', 'twelve plus one' ] ),
        rx{
            ^ \[                                             \s
                   '("eleven plus two", "twelve plus one"),' \s+
                   '("Madam Curie", "Radium came"),'         \s+
                   '("October Sky", "Rocket Boys"),'         \s+
                   '("fluster", "restful"),'                 \s+
                   '("listen", "silent")'                    \s
              \] $
          },
        'Wikipedia'
    );
}

##############################################################################
