use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 173
=========================

TASK #2
-------
*Sylvester’s sequence*

Submitted by: Mohammad S Anwar

Write a script to generate first 10 members of Sylvester's sequence. For more
informations, please refer to the [ https://en.wikipedia.org/wiki/Sylvester
%27s_sequence |wikipedia page].

Output

  2
  3
  7
  43
  1807
  3263443
  10650056950807
  113423713055421844361000443
  12864938683278671740537145998360961546653259485195807
  165506647324519964198468195444439180017513152706377497841851388766535868639
     572406808911988131737645185443

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Since numbers in Sylvester's sequence quickly become very large, they may be
easier to read with their digits separated into groups of 3. To do this, set
the constant $SEP to the value of the separator required (e.g., a comma or a
space).

Algorithm
---------
The large numbers are automatically accommodated by using the Raku type Int,
which "offers arbitrary-size integer numbers". [2]

Successive elements of Sylvester's sequence are calculated using the recurrence
relation:

    a(n+1) = a(n)² - a(n) + 1

from [1]. This is re-arranged to the equivalent:

    a(n+1) = a(n) × (a(n) - 1) + 1.

References
----------
[1] "A000058 Sylvester's sequence: a(n+1) = a(n)^2 - a(n) + 1, with a(0) = 2.",
     OEIS, https://oeis.org/A000058
[2] "Numerics", Raku Documentation, https://docs.raku.org/language/numerics
[3] "Sylvester's sequence", Wikipedia,
     https://en.wikipedia.org/wiki/Sylvester%27s_sequence

=end comment
#==============================================================================

my Str  constant $SEP    = '';
my UInt constant $TARGET = 10;
my UInt constant $WRAP   = 72;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 173, Task #2: Sylvester's sequence (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    "The first $TARGET numbers of Sylvester's sequence:".put;

    my UInt $sylvester = 2;

    "%2d:  %d\n".printf: 1, $sylvester;

    for 2 .. $TARGET -> UInt $i
    {
        $sylvester *= $sylvester - 1;
      ++$sylvester;

        my Str $string = $SEP ?? add-commas( $sylvester, $SEP )
                              !! $sylvester.Str;
               $string = $string.substr( 0, $WRAP ) ~ "\n     " ~
                         $string.substr( $WRAP    ) if $string.chars > $WRAP;

        "%2d:  %s\n".printf: $i, $string;
    }
}

#-------------------------------------------------------------------------------
# Adapted from commatize() at
# http://www.rosettacode.org/wiki/Commatizing_numbers#Raku
#
sub add-commas( Int:D $number, Str:D $sep --> Str:D )
#-------------------------------------------------------------------------------
{
    $number.subst: / <[ 1 .. 9 ]> <[ 0 .. 9 ]>* /,
                   *.flip.comb( / <{ ".**1..3" }> / ).join( $sep ).flip;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
