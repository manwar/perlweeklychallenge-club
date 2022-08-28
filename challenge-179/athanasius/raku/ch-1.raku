use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 179
=========================

TASK #1
-------
*Ordinal Number Spelling*

Submitted by: Mohammad S Anwar

You are given a positive number, $n.

Write a script to spell the ordinal number.

For example,

  11 => eleventh
  62 => sixty-second
  99 => ninety-ninth

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
1. Ordinal names use the short scale. [1]
2. Valid input is any integer $n in the range 0 < $n < 10^21.

Interface
---------
If $n is not supplied on the command line, the in-file test suite is run
instead.

Note
----
Script output tested under Windows 8.1 using Rakudo v2022.04 (implementing Raku
v6.d).

Reference
---------
[1] "Long and short scales", Wikipedia,
     https://en.wikipedia.org/wiki/Long_and_short_scales

=end comment
#==============================================================================

use Test;

my constant $MAX   = 10 ** 21 - 1;                    # One sextillion less one

my constant %UNITS = 

    CARDINAL =>
    [ '', |< one   two    three four   five  six   seven   eight  nine  > ],
    ORDINAL  =>
    [ '', |< first second third fourth fifth sixth seventh eighth ninth > ];

my constant @TEENS = < ten     eleven  twelve    thirteen fourteen
                       fifteen sixteen seventeen eighteen nineteen >;

my constant @TENS  = '', '', |< twenty thirty  forty  fifty
                                sixty  seventy eighty ninety >;

my constant @LARGE = < thousand million     billion
                       trillion quadrillion quintillion >;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 179, Task #1: Ordinal Number Spelling (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    UInt:D $n where { 0 < $n <= $MAX }   #= A natural number below 1 sextillion
)
#==============================================================================
{
    my UInt $num = $n + 0;              # Normalise (remove any initial zeroes)

    "Input:  %s\n".printf: add-commas( $num );
    "Output: %s\n".printf: ordinal\  ( $num );
}

#==============================================================================
multi sub MAIN()
#==============================================================================
{
    run-tests;
}

#-------------------------------------------------------------------------------
sub ordinal( UInt:D $n where * > 0 --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $num      = '0' x ((3 - $n.chars % 3) % 3) ~ $n;     # Prepend zeroes
    my Str @triples  = ($num ~~ m:g/ (\d ** 3) /).map: { .Str };  # Group digits
    my Str $ls-digs  = @triples[ *-1 ];               # Least significant digits
    my Str $hundreds = hundreds( @triples.pop, True );
    my Str @ordinal;
           @ordinal.push: $hundreds if $hundreds;

    loop (my UInt $index = 0; @triples.elems > 0; ++$index)
    {
        if (my Str $n = @triples.pop) > 0
        {
            @ordinal.push: hundreds( $n, False ) ~ ' ' ~ @LARGE[ $index ];
        }
    }

    return format-ordinal( @ordinal, $ls-digs );
}

#------------------------------------------------------------------------------
sub hundreds( Str:D $n, Bool:D $ordinal --> Str:D )
#------------------------------------------------------------------------------
{
    my Str ($hundreds, $tens) = ($n ~~ / ^ (\d) (\d ** 2) $ /).map: { .Str };
    my Str  $name             = tens( $tens, $ordinal );

    if $hundreds > 0
    {
        $name = %UNITS< CARDINAL >[ $hundreds ] ~ ' hundred' ~
                (($tens == 0) ?? '' !! ($name ?? " and $name" !! 'th'));
    }

    return $name;
}

#------------------------------------------------------------------------------
sub tens( Str:D $n, Bool:D $ordinal --> Str:D )
#------------------------------------------------------------------------------
{
    return '' if $n.Int == 0;

    my Str ($tens, $units) = ($n ~~ / ^ (\d) (\d) $ /).map: { .Str };

    my Str  $key  =  $ordinal    ?? 'ORDINAL' !! 'CARDINAL';
    my Str  $name = ($tens == 1) ?? @TEENS[ $units ] ~ ($ordinal ?? 'th' !! '')
                                 !! %UNITS{ $key }[ $units ];

    if $tens > 1
    {
        my Str $tens-name = @TENS[ $tens ];

        if    $units > 0
        {
            $name = $tens-name ~ '-' ~ $name;
        }
        elsif $ordinal
        {
            $name = $tens-name.substr( 0, $tens-name.chars - 1 ) ~ 'ieth';
        }
        else
        {
            $name = $tens-name;
        }
    }

    return $name;
}

#-------------------------------------------------------------------------------
sub format-ordinal( Array:D[Str:D] $ord-array, Str:D $ls-digs --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str $ordinal;

    if    @$ord-array.elems == 1
    {
        $ordinal = $ord-array[ 0 ] ~ ($ls-digs %% 100 ?? 'th' !! '');
    }
    elsif $ls-digs %% 100
    {
        $ordinal = $ord-array.reverse.join( ' ' ) ~ 'th';
    }   
    elsif $ls-digs ~~ / ^ 0 /
    {
        $ordinal = $ord-array[ 1 .. $ord-array.end ].reverse.join( ' ' ) ~
                   ' and ' ~ $ord-array[ 0 ];
    }
    else
    {
        $ordinal = $ord-array.reverse.join: ' ';
    }

    return $ordinal;
}

#-------------------------------------------------------------------------------
# From https://rosettacode.org/wiki/Commatizing_numbers#Raku
#
sub add-commas( $s, :$at = 0, :$ins = ',', :$by = 3 )
#-------------------------------------------------------------------------------
{
    $s.subst: :continue( $at ), :1st, / <[1..9]> <[0..9]>* /,
        *.flip.comb( / <{ ". ** 1..$by" }> / ).join( $ins ).flip;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    for test-data.lines -> Str $line
    {
        my Str $test = $line.chomp;

        $test ~~ s/ ^ (\s+) //;                     # Remove initial whitespace

        my Str ($n, $expected) =  $test.split: /\s+/, 2, :skip-empty;
        my Str  $test-name     = '(%s)'.sprintf: add-commas( $n );

        is ordinal( $n.Int ), $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
                    1 first
                    2 second
                    3 third
                    4 fourth
                   10 tenth
                   11 eleventh
                   19 nineteenth
                   20 twentieth
                   21 twenty-first
                   37 thirty-seventh
                   62 sixty-second
                   99 ninety-ninth
                  100 one hundredth
                  201 two hundred and first
                  310 three hundred and tenth
                  425 four hundred and twenty-fifth
                  590 five hundred and ninetieth
                 2345 two thousand three hundred and forty-fifth
                 5000 five thousandth
                 6100 six thousand one hundredth
               100000 one hundred thousandth
               101001 one hundred and one thousand and first
               101110 one hundred and one thousand one hundred and tenth
              1000069 one million and sixty-ninth
              9000999 nine million nine hundred and ninety-ninth
              9001000 nine million one thousandth
           6000000000 six billionth
           6000000050 six billion and fiftieth
           6000007000 six billion seven thousandth
           7000000003 seven billion and third
           1034000890 one billion thirty-four million eight hundred and ninetieth
  1000000000000000000 one quintillionth
  1000000000000001343 one quintillion one thousand three hundred and forty-third
999999999999999999999 nine hundred and ninety-nine quintillion nine hundred and ninety-nine quadrillion nine hundred and ninety-nine trillion nine hundred and ninety-nine billion nine hundred and ninety-nine million nine hundred and ninety-nine thousand nine hundred and ninety-ninth
END
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
