use v6;

################################################################################
=begin comment

Perl Weekly Challenge 053
=========================

Task #2
*Vowel Strings*

Write a script to accept an integer *1 <= N <= 5* that would print all possible
[distinct] strings of size *N* formed by using only vowels (*a, e, i, o, u*).

The string should follow the following rules:

    1. 'a' can only be followed by 'e' and 'i'.

    2. 'e' can only be followed by 'i'.

    3. 'i' can only be followed by 'a', 'e', 'o', and 'u'.

    4. 'o' can only be followed by 'a' and 'u'.

    5. 'u' can only be followed by 'o' and 'e'.

For example, if the given integer *N = 2* then script should print the following
strings:

  ae
  ai
  ei
  ia
  io
  iu
  ie
  oa
  ou
  uo
  ue

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $MIN-N     = 1;
my UInt constant $MAX-N     = 5;
my      constant %FOLLOWERS = a => < e i     >,
                              e => < i       >,
                              i => < a e o u >,
                              o => < a u     >,
                              u => < o e     >;

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    UInt:D $N where $MIN-N <= $N && $N <= $MAX-N    #= String size (1 <= N <= 5)
)
#===============================================================================
{
    "Challenge 053, Task #2: Vowel Strings (Raku)\n".put;

    my Str @solution = < a e i o u >;                   # The solution for N = 1

    for 2 .. $N
    {
        my Str @temp;

        for @solution -> Str $string
        {
            my Str $last = $string.substr: *-1;

            @temp.push: $string ~ $_ for %FOLLOWERS{ $last };
        }

        @solution = @temp;
    }

    "For N = %d, the %d possible distinct vowel strings are:\n  %s\n".printf:
        $N, @solution.elems, @solution.join: "\n  ";
}

################################################################################
