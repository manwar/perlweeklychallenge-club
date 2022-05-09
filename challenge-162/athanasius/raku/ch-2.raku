use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 162
=========================

TASK #2
-------
*Wheatstone-Playfair*

Submitted by: Roger Bell_West

Implement encryption and decryption using the [ https://en.wikipedia.org/wiki/
Playfair_cipher |Wheatstone-Playfair cipher].

Examples:

  (These combine I and J, and use X as padding.)

  encrypt("playfair example", "hide the gold in the tree stump") =
  "bmodzbxdnabekudmuixmmouvif"

  decrypt("perl and raku", "siderwrdulfipaarkcrw") = "thewexeklychallengex"

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----
1. The algorithm presented in the Wikipedia article does not cover the case in
   which the letter 'X' occurs twice in succession in the given plaintext. To
   prevent an infinite regress in this situation, I have provided a second
   padding character, 'Q'.

2. Set $SPACING to 0 to get encrypted output without spaces, as in the example.
   I have set it to 5 as per the Wikepedia article.

=end comment
#==============================================================================

my Str  constant $PADDING_1 = 'x';
my Str  constant $PADDING_2 = 'q';
my UInt constant $SPACING   =  5;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 162, Task #2: Wheatstone-Playfair (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Str:D  :$key,                     #= Cipher key
    Str:D  :$text,                    #= Plaintext or ciphertext
    Bool:D :$decrypt = False          #= Decrypt instead of encrypt?
)
#==============================================================================
{
    if $decrypt
    {
        ("Input\n-----\n  Key:        '$key'\n"  ~
                       "  Ciphertext: '$text'\n" ~
                       "  Mode:        Decrypt\n").put;

        my Str $plain  = decode( $key, $text );

        "Output\n------\n  Plaintext:  '$plain'".put;
    }
    else    # Encrypt
    {
        ("Input\n-----\n  Key:        '$key'\n"  ~
                       "  Plaintext:  '$text'\n" ~
                       "  Mode:        Encrypt\n").put;

        my Str $cipher = encode( $key, $text );

        "Output\n------\n  Ciphertext: '$cipher'".put;
    }
}

#------------------------------------------------------------------------------
sub encode( Str:D $key, Str:D $text-orig --> Str:D )
#------------------------------------------------------------------------------
{
    my Array[Array[Str]] $table;
    my Array[UInt]       %l2rc;

    ($table, %l2rc) = make-table( $key );

    my Str $text = $text-orig.lc;
           $text ~~ s:g/ <-[a .. z]> //;     # Remove spaces, punctuation, etc.

    my Str $cipher = '';

    for get-digrams( $text ) -> Str @digram
    {
        $cipher ~= encode-digram( @digram, $table, %l2rc );
    }

    $cipher ~~ s:g/ (. ** {$SPACING}) /$0 / if $SPACING > 0;

    return $cipher;
}

#------------------------------------------------------------------------------
sub decode( Str:D $key, Str:D $text-orig --> Str:D )
#------------------------------------------------------------------------------
{
    my Array[Array[Str]] $table;
    my Array[UInt]       %l2rc;

    ($table, %l2rc) = make-table( $key );

    my Str $text = $text-orig.lc;            # Just in case
           $text ~~ s:g/ <-[a .. z]> //;     # Remove spaces, etc.

    my Str $plain = '';

    for get-digrams( $text ) -> Str @digram
    {
        $plain ~= decode-digram( @digram, $table, %l2rc );
    }

    return $plain;
}

#------------------------------------------------------------------------------
sub encode-digram
(
    Array:D[Str:D]          $digram,
    Array:D[Array:D[Str:D]] $table,
    Hash:D[Array:D[UInt:D]] $l2rc
--> Str:D
)
#------------------------------------------------------------------------------
{
    my Str   $code                     = '';
    my UInt ($first-row,  $first-col)  = $l2rc{ $digram[ 0 ] };
    my UInt ($second-row, $second-col) = $l2rc{ $digram[ 1 ] };

    if    $first-row == $second-row
    {
        my UInt $i = $first-col  + 1;
                $i = 0 if $i > 4;

        my UInt $j = $second-col + 1;
                $j = 0 if $j > 4;

        $code = $table[ $first-row;  $i ] ~
                $table[ $second-row; $j ];
    }
    elsif $first-col == $second-col
    {
        my UInt $i = $first-row  + 1;
                $i = 0 if $i > 4;

        my UInt $j = $second-row + 1;
                $j = 0 if $j > 4;

        $code = $table[ $i; $first-col  ] ~
                $table[ $j; $second-col ];
    }
    else
    {
        $code = $table[ $first-row;  $second-col ] ~
                $table[ $second-row; $first-col  ];
    }

    return $code;
}

#------------------------------------------------------------------------------
sub decode-digram
(
    Array:D[Str:D]          $digram,
    Array:D[Array:D[Str:D]] $table,
    Hash:D[Array:D[UInt:D]] $l2rc
--> Str:D
)
#------------------------------------------------------------------------------
{
    my Str   $text                     = '';
    my UInt ($first-row,  $first-col)  = $l2rc{ $digram[ 0 ] };
    my UInt ($second-row, $second-col) = $l2rc{ $digram[ 1 ] };

    if    $first-row == $second-row
    {
        my Int $i = $first-col  - 1;
               $i = 4 if $i < 0;

        my Int $j = $second-col - 1;
               $j = 4 if $j < 0;

        $text = $table[ $first-row;  $i ] ~
                $table[ $second-row; $j ];
    }
    elsif $first-col == $second-col
    {
        my Int $i = $first-row  - 1;
               $i = 4 if $i < 0;

        my Int $j = $second-row - 1;
               $j = 4 if $j < 0;

        $text = $table[ $i; $first-col  ] ~
                $table[ $j; $second-col ];
    }
    else
    {
        $text = $table[ $first-row;  $second-col ] ~
                $table[ $second-row; $first-col  ];
    }

    return $text;
}

#------------------------------------------------------------------------------
sub make-table
(
    Str:D $key-orig
--> List:D[ Array:D[Array:D[Str:D]], Hash:D[Array:D[UInt:D]] ]
)
#------------------------------------------------------------------------------
{
    my Array[Str] @table;

    push @table, Array[Str].new: Nil xx 5 for 0 .. 4;

    my Str $key =  $key-orig.lc;
           $key ~~ s:g/ <-[a .. z]> //;
           $key ~= $_ for 'a' .. 'z';
           $key ~~ tr/j/i/;

    my Array:D[UInt:D] %l2rc;
    my UInt            %alphabet   = ('a' .. 'z').map: { $_ => 0 };
    my UInt           ($row, $col) = (0, 0);

    for $key.split: '', :skip-empty -> Str $letter
    {
        unless %alphabet{ $letter }++
        {
            @table[$row][$col] = $letter;
            %l2rc{ $letter }   = Array[UInt].new: $row, $col;

            if ++$col > 4
            {
                $col = 0;
                last if ++$row > 4;
            }
        }
    }

    %l2rc{ 'j' } = %l2rc{ 'i' };

    return @table, %l2rc;
}

#------------------------------------------------------------------------------
sub get-digrams( Str:D $text --> Array:D[Array:D[Str:D]] )
#------------------------------------------------------------------------------
{
    my Array[Str] @digrams;
    my Str        @letters = $text.split: '', :skip-empty;

    while +@letters
    {
        my Str $first = @letters.shift;
        my Str $second;

        if   +@letters == 0 || @letters[ 0 ] eq $first
        {
            $second = ($first eq $PADDING_1) ?? $PADDING_2 !! $PADDING_1;
        }
        else
        {
            $second = @letters.shift;
        }

        @digrams.push: Array[Str].new: $first, $second;
    }

    return @digrams;
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
