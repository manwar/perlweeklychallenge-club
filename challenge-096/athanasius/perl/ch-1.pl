#!perl

###############################################################################
=comment

Perl Weekly Challenge 096
=========================

Task #1
-------
*Reverse Words*

Submitted by: Mohammad S Anwar

You are given a string $S.

Write a script to reverse the order of words in the given string. The string
may contain leading/trailing spaces. The string may have more than one space
between words in the string. Print the result without leading/trailing spaces
and there should be only one space between words.

Example 1:

 Input: $S = "The Weekly Challenge"
 Output: "Challenge Weekly The"

Example 2:

 Input: $S = "    Perl and   Raku are  part of the same family  "
 Output: "family same the of part are Raku and Perl"

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
- "Spaces" include all whitespace characters.
-  Any punctuation attached to a word is to be considered a part of that word,
   e.g., "Fred and Wilma, Barney and Betty" becomes
         "Betty and Barney Wilma, and Fred"
   with the comma still attached to "Wilma" as in the original string.

Implementation
--------------
Split the string on whitespace, reverse the result, and re-join the reversed
list of words into a single string using single spaces.

For split()ting, advantage is taken of the the special case where the pattern
to split on is a single space character, as documented in https://perldoc.pl/
functions/split:

 "split /PATTERN/,EXPR
  ...
 "As another special case, split emulates the default behavior of the command
  line tool awk when the PATTERN is either omitted or a string composed of a
  single space character (such as ' ' or "\x20", but not e.g. / /). In this
  case, any leading whitespace in EXPR is removed before splitting occurs, and
  the PATTERN is instead treated as if it were /\s+/; in particular, this means
  that any contiguous whitespace (not just a single space character) is used as
  a separator."

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $USAGE =>
"Usage:
  perl $0 <S>

    <S>    A single string containing words separated by whitespace\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 096, Task #1: Reverse Words (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $S = parse_command_line();

    printf qq[Input:  "%s"\n], $S;
    printf qq[Output: "%s"\n], join ' ', reverse split ' ', $S;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        die "ERROR: No command-line arguments\n$USAGE";
    }
    elsif ($args >  1)
    {
        die "ERROR: Too many command-line arguments\n$USAGE";
    }

    return $ARGV[0];
}

###############################################################################
