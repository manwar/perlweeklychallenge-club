use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 166
=========================

TASK #1
-------
*Hexadecimal Words*

Submitted by: Ryan J Thompson

As an old systems programmer, whenever I needed to come up with a 32-bit num-
ber, I would reach for the tired old examples like 0xDeadBeef and 0xC0dedBad. I
want more!

Write a program that will read from a dictionary and find 2- to 8-letter words
that can be “spelled” in hexadecimal, _with_ the addition of the following
letter substitutions:

 • o ⟶ 0 (e.g., 0xf00d = “food”)
 • l ⟶ 1
 • i ⟶ 1
 • s ⟶ 5
 • t ⟶ 7

You can use your own dictionary or you can simply open
../../../data/dictionary.txt (relative to your script’s location in our
[ https://github.com/manwar/perlweeklychallenge-club |GitHub repository]) to
access the dictionary of common words from
[ https://theweeklychallenge.org/blog/perl-weekly-challenge-161/ |Week #161].

Optional Extras (for an 0xAddedFee, of course!)
       1. Limit the number of “special” letter substitutions in any one result
          to keep that result at least somewhat comprehensible. (0x51105010 is
          an actual example from my sample solution you may wish to avoid!)

       2. Find _phrases_ of words that total 8 characters in length (e.g.,
          0xFee1Face), rather than just individual words.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Optional Extras
---------------
1. Limit "special" letter substitutions. Command-line options:

   --single   Prevent '1' from representing both 'i' and 'l' in the same word.
              Applies before --max or --prop.
   --max=i    Limit the total number of digits in any word to the given integer
              (which must be between 0 and 8 inclusive). Takes precedence over
              the --prop flag.
   --prop=f   Limit the number of digits in any word to the given floating-
              point number, which is the proportion of digits to total char-
              acters. Must be between 0 and 1 inclusive. Has no effect if the
              --max flag is also set.

2. Find phrases. Command-line option:

   --phrases  Only 8-character phrases are output: 8-character words, and
              phrases composed of 2 shorter words. Where the phrase contains 2
              words, the shorter of the two appears first. Note that the
              command-line flags described above apply to the selection of
              individual words, before phrases are constructed.
=end comment
#==============================================================================

my Str      constant $DICTIONARY  = '../../../data/dictionary.txt';
my Set[Str] constant $HEX-LETTERS = Set[Str].new: 'a' .. 'f';
my          constant %HEX-NUMBERS = :i('1'), :l('1'), :o('0'), :s('5'),
                                    :t('7');
my Set[Str] constant $LETTERS     = $HEX-LETTERS ∪
                                    Set[Str].new: %HEX-NUMBERS.keys;
my UInt     constant $MIN-LETTERS = 2;
my UInt     constant $MAX-LETTERS = 8;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 166, Task #1: Hexadecimal Words (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:_  :max(:$max-numbers),               #= Maximum digits in word
    Real:_ :prop(:$max-proportion),           #= Maximum proportion of digits
    Bool:D :single(:$single-def1)   = False,  #= Disallow '1' as both 'I' & 'L'
    Bool:D :phrases(:$find-phrases) = False,  #= Find 8-letter phrases
)
#==============================================================================
{
    validate-arguments( $max-numbers, $max-proportion );

    my Array[Str] @words;

    for $DICTIONARY.IO.lines -> Str $line
    {
        my Str  $word   = $line.chomp.tc;
        my UInt $length = $word.chars;

        if $MIN-LETTERS <= $length <= $MAX-LETTERS
        {
            my Set[Str] $chars = Set[Str].new:
                $word.split( '', :skip-empty ).map: { .lc };

            if $chars ⊆ $LETTERS
            {
                my Str $hex = test-word( $word, $max-numbers,
                                         $max-proportion,  $single-def1 );

                @words.push: Array[Str].new( $word, $hex ) if $hex.defined;
            }
        }
    }

    display-words( $find-phrases ?? find-phrases( @words ) !! @words );
}

#------------------------------------------------------------------------------
sub find-phrases
(
    Array:D[Array:D[Str:D]] $words
--> Array:D[Array:D[Str:D]]
)
#------------------------------------------------------------------------------
{
    my Array[Array[Str]] %len2words;

    for @$words -> Array[Str] $word
    {
        %len2words{ $word[ 0 ].chars }.push: $word;
    }

    my Array[Str] @phrases = |%len2words{ $MAX-LETTERS };

    for 1 .. ($MAX-LETTERS / 2).floor -> UInt $i
    {
        next if $i == 1;

        my UInt $j = $MAX-LETTERS - $i;

        for %len2words{ $i }.list -> Array[Str] $word-i
        {
            for %len2words{ $j }.list -> Array[Str] $word-j
            {
                @phrases.push: Array[Str].new: $word-i[ 0 ] ~ $word-j[ 0 ],
                                               $word-i[ 1 ] ~ $word-j[ 1 ];
            }
        }
    }

    return @phrases;
}

#------------------------------------------------------------------------------
sub test-word
(
    Str:D  $word,
    UInt   $max-numbers,
    Real   $max-proportion,
    Bool:D $single-def1
--> Str
)
#------------------------------------------------------------------------------
{
    return if $single-def1 && $word ~~ m:i/ I / && $word ~~ m:i/ L /;

    my Str @chars = $word.split: '', :skip-empty;
    my Str $hex;

    for @chars -> Str $char
    {
        if %HEX-NUMBERS{ $char.lc }:exists
        {
            $hex ~= %HEX-NUMBERS{ $char.lc };
        }
        else
        {
            $hex ~= $char;
        }
    }

    $hex ~~ m:g/ \d /;
    my UInt $nums = $/.elems;

    return if $max-numbers.defined    && $nums > $max-numbers;
    return if $max-proportion.defined && $nums / $hex.chars > $max-proportion;

    return $hex;
}

#------------------------------------------------------------------------------
sub display-words
(
    Array:D[Array:D[Str:D]] $words
)
#------------------------------------------------------------------------------
{
    '  Word      Hex'.put;
    '  --------------------'.put;

    for @$words -> Array[Str] $word
    {
        "  %-8s  0x%-10s\n".printf: $word[ 0 ], $word[ 1 ];
    }

    '  --------------------'.put;
    "  Count: %d\n".printf: +@$words;
}

#------------------------------------------------------------------------------
sub validate-arguments
(
    UInt $max-numbers,
    Real $max-proportion
)
#------------------------------------------------------------------------------
{
    if $max-numbers.defined
    {
        0 <= $max-numbers <= $MAX-LETTERS
            or error( qq[Invalid value "$max-numbers" for max] );
    }

    if $max-proportion.defined
    {
        0 <= $max-proportion <= 1
            or error( qq[Invalid value "$max-proportion" for prop] );
    }
}

#------------------------------------------------------------------------------
sub error
(
    Str:D $message
)
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
