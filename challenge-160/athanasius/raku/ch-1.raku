use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 160
=========================

TASK #1
-------
*Four Is Magic*

Submitted by: Mohammad S Anwar

You are given a positive number, $n < 10.

Write a script to generate english text sequence starting with the English
cardinal representation of the given number, the word ‘is’ and then the English
cardinal representation of the count of characters that made up the first word,
followed by a comma. Continue until you reach four.

Example 1:

  Input: $n = 5
  Output: Five is four, four is magic.

Example 2:

  Input: $n = 7
  Output: Seven is five, five is four, four is magic.

Example 3:

  Input: $n = 6
  Output: Six is three, three is five, five is four, four is magic.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
I take "a positive number" < 10 to be an integer in the range 0 to 9 inclusive.
(Should an input of zero be allowed? The answer depends on one's definition of
"positive". I interpret "positive" here as "non-negative", and therefore allow
zero as an input value.)

Output
------
What should the output be when $n = 4? Taking the Task description literally,
it should be: "Four is four, four is magic.", but this seems redundant. Since
there is no obviously correct answer to this question, I give the longer output
as the default, but provide the constant $SHORT: if it is set to True, the
output is shortened to just "Four is magic." when $n = 4.

Algorithm
---------
Since there are only 10 cases to consider, I've pre-computed the word lengths:
the name and length of each digit are stored as a key-value Pair against that
digit's index in the constant array @DIGITS.

The algorithm proceeds by finding the length of the current number's name in
characters (by table lookup) and printing that number's name, "is", the name of
that number's length, and a comma. That length then becomes the current number,
and the process repeats until the current number is 4, at which point the
algorithm ends by printing "four is magic."

=end comment
#==============================================================================

my UInt constant $MAX    = 9;
my      constant @DIGITS = Array[Pair].new:
                 (
                     zero => 4, one => 3, two   => 3, three => 5, four => 4,
                     five => 4, six => 3, seven => 5, eight => 5, nine => 4,
                 );
my Bool constant $SHORT  = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 160, Task #1: Four Is Magic (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $n where 0 <= * <= $MAX      #= An integer between 0 and 9 inclusive
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    if $SHORT && $n == 4
    {
        'Output: Four is magic.'.put;
    }
    else
    {
        my Str  $name   = @DIGITS[ $n ].key;
        my UInt $length = @DIGITS[ $n ].value;

        'Output: %s is %s, '.printf: $name.tc, @DIGITS[ $length ].key;

        until $length == 4
        {
            $name   = @DIGITS[ $length ].key;
            $length = @DIGITS[ $length ].value;

            '%s is %s, '.printf: $name, @DIGITS[ $length ].key;
        }

        'four is magic.'.put;
    }
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
