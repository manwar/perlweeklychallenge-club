#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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

=cut
#==============================================================================

use strict;
use warnings;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 094, Task #1: Group Anagrams (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    if (scalar @ARGV > 0)
    {
        my @S = @ARGV;

        printf "Input: (%s)\n", join ', ', map { qq["$_"] } @S;
        printf "Output: %s\n",  group_anagrams( @S );
    }
    else
    {
        test();
    }
}

#------------------------------------------------------------------------------
sub group_anagrams
#------------------------------------------------------------------------------
{
    my @S = @_;
    my %anagrams;

    for my $string (@S)
    {
        my $key = join '', sort split //, lc $string;

        if (exists $anagrams{$key})
        {
            my $found = 0;

            for my $anagram (@{ $anagrams{$key} })
            {
                if ($anagram eq $string)
                {
                    $found = 1;
                    last;
                }
            }

            push @{ $anagrams{$key} }, $string unless $found;
        }
        else
        {
            $anagrams{$key} = [ $string ];
        }
    }

    return format_output( \%anagrams );
}

#------------------------------------------------------------------------------
sub format_output
#------------------------------------------------------------------------------
{
    my ($anagrams) = @_;
    my  $output    = '[ ';
    my  $first     = 1;

    for my $key (sort keys %$anagrams)
    {
        $output .= ",\n          " unless $first;
        $first   = 0;
        $output .= '(';
        $output .= join ', ', map { qq["$_"] } sort @{ $anagrams->{$key} };
        $output .= ')';
    }
 
    $output .= ' ]';

    return $output;
}

#------------------------------------------------------------------------------
sub test
#------------------------------------------------------------------------------
{
    use Test::More;
    plan tests => 3;

    like
    (
        group_anagrams( qw[ opt bat saw tab pot top was ] ),
        qr{
            ^ \[                             \s
                   \Q("bat", "tab"),\E       \s+
                   \Q("saw", "was"),\E       \s+
                   \Q("opt", "pot", "top")\E \s
              \] $
          }x,
        'Example 1'
    );

    like
    (
        group_anagrams( 'x' ),
        qr{
            ^ \[             \s
                   \Q("x")\E \s
              \] $
          }x,
        'Example 2'
    );

    like
    (
        group_anagrams( 'Radium came', 'restful', 'eleven plus two', 'silent',
                        'October Sky', 'listen', 'Madam Curie', 'fluster',
                        'Rocket Boys', 'twelve plus one' ),
        qr{
            ^ \[                                               \s
                   \Q("eleven plus two", "twelve plus one"),\E \s+
                   \Q("Madam Curie", "Radium came"),\E         \s+
                   \Q("October Sky", "Rocket Boys"),\E         \s+
                   \Q("fluster", "restful"),\E                 \s+
                   \Q("listen", "silent")\E                    \s
              \] $
          }x,
        'Wikipedia'
    );
}

###############################################################################
