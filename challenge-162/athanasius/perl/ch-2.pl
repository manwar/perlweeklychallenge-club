#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Notes
-----
1. The algorithm presented in the Wikipedia article does not cover the case in
   which the letter 'X' occurs twice in succession in the given plaintext. To
   prevent an infinite regress in this situation, I have provided a second
   padding character, 'Q'.

2. Set $SPACING to 0 to get encrypted output without spaces, as in the example.
   I have set it to 5 as per the Wikepedia article.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $PADDING_1 => 'x';
const my $PADDING_2 => 'q';
const my $SPACING   =>  5;
const my $USAGE     =>
"Usage:
  perl $0 [--key=<Str>] [--text=<Str>] [--decrypt]

    --key=<Str>     Cipher key
    --text=<Str>    Plaintext or ciphertext
    --decrypt       Decrypt instead of encrypt? [default: False]\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 162, Task #2: Wheatstone-Playfair (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($key, $text, $decrypt) = parse_command_line();

    if ($decrypt)
    {
        print "Input\n-----\n  Key:        '$key'\n"  .
                            "  Ciphertext: '$text'\n" .
                            "  Mode:        Decrypt\n\n";

        my $plain  = decode( $key, $text );

        print "Output\n------\n  Plaintext:  '$plain'\n";
    }
    else    # Encrypt
    {
        print "Input\n-----\n  Key:        '$key'\n"  .
                            "  Plaintext:  '$text'\n" .
                            "  Mode:        Encrypt\n\n";

        my $cipher = encode( $key, $text );

        print "Output\n------\n  Ciphertext: '$cipher'\n";
    }
}

#------------------------------------------------------------------------------
sub encode
#------------------------------------------------------------------------------
{
    my ($key,   $text) = @_;
    my ($table, $l2rc) = make_table( $key );

    $text =  lc $text;
    $text =~ s/ [^a-z] //gx;                 # Remove spaces, punctuation, etc.

    my $cipher = '';

    for my $digram (get_digrams( $text ))
    {
        $cipher .= encode_digram( $digram, $table, $l2rc );
    }

    $cipher =~ s/ (.{$SPACING}) /$1 /gx if $SPACING > 0;

    return $cipher;
}

#------------------------------------------------------------------------------
sub decode
#------------------------------------------------------------------------------
{
    my ($key, $text) = @_;
    my ($table, $l2rc) = make_table( $key );

    $text =  lc $text;                       # Just in case
    $text =~ s/ [^a-z] //gx;                 # Remove spaces, etc.

    my $plain = '';

    for my $digram (get_digrams( $text ))
    {
        $plain .= decode_digram( $digram, $table, $l2rc );
    }

    return $plain;
}

#------------------------------------------------------------------------------
sub encode_digram
#------------------------------------------------------------------------------
{
    my ($digram, $table, $l2rc)   = @_;
    my  $code                     = '';
    my ($first_row,  $first_col)  = @{ $l2rc->{ $digram->[ 0 ] } };
    my ($second_row, $second_col) = @{ $l2rc->{ $digram->[ 1 ] } };

    if    ($first_row == $second_row)
    {
        my $i = $first_col  + 1;
           $i = 0 if $i > 4;

        my $j = $second_col + 1;
           $j = 0 if $j > 4;

        $code = $table->[ $first_row  ][ $i ] .
                $table->[ $second_row ][ $j ];
    }
    elsif ($first_col == $second_col)
    {
        my $i = $first_row  + 1;
           $i = 0 if $i > 4;

        my $j = $second_row + 1;
           $j = 0 if $j > 4;

        $code = $table->[ $i ][ $first_col  ] .
                $table->[ $j ][ $second_col ];
    }
    else
    {
        $code = $table->[ $first_row  ][ $second_col ] .
                $table->[ $second_row ][ $first_col  ];
    }

    return $code;
}

#------------------------------------------------------------------------------
sub decode_digram
#------------------------------------------------------------------------------
{
    my ($digram, $table, $l2rc)   = @_;
    my  $text                     = '';
    my ($first_row,  $first_col)  = @{ $l2rc->{ $digram->[ 0 ] } };
    my ($second_row, $second_col) = @{ $l2rc->{ $digram->[ 1 ] } };

    if    ($first_row == $second_row)
    {
        my $i = $first_col  - 1;
           $i = 4 if $i < 0;

        my $j = $second_col - 1;
           $j = 4 if $j < 0;

        $text = $table->[ $first_row  ][ $i ] .
                $table->[ $second_row ][ $j ];
    }
    elsif ($first_col == $second_col)
    {
        my $i = $first_row  - 1;
           $i = 4 if $i < 0;

        my $j = $second_row - 1;
           $j = 4 if $j < 0;

        $text = $table->[ $i ][ $first_col  ] .
                $table->[ $j ][ $second_col ];
    }
    else
    {
        $text = $table->[ $first_row  ][ $second_col ] .
                $table->[ $second_row ][ $first_col  ];
    }

    return $text;
}

#------------------------------------------------------------------------------
sub make_table
#------------------------------------------------------------------------------
{
    my  ($key)  = @_;
    my   @table;
    push @table, [ (undef) x 5 ] for 0 .. 4;

    $key  =  lc $key;
    $key  =~ s/[^a-z]//g;
    $key .=  $_ for 'a' .. 'z';
    $key  =~ tr/j/i/;

    my  %l2rc;
    my  %alphabet   =  map { $_ => 0 } 'a' .. 'z';
    my ($row, $col) = (0, 0);

    for my $letter (split '', $key)
    {
        unless ($alphabet{ $letter }++)
        {
            $table[$row][$col] = $letter;
            $l2rc{ $letter }   = [ $row, $col ];

            if (++$col > 4)
            {
                $col = 0;
                last if ++$row > 4;
            }
        }
    }

    $l2rc{ j } = [ @{ $l2rc{ i } } ];

    return (\@table, \%l2rc);
}

#------------------------------------------------------------------------------
sub get_digrams
#------------------------------------------------------------------------------
{
    my ($text) = @_;
    my  @digrams;
    my  @letters = split '', $text;

    while (scalar @letters)
    {
        my $first = shift @letters;
        my $second;

        if    (scalar @letters == 0 || $letters[ 0 ] eq $first)
        {
            $second = ($first eq $PADDING_1) ? $PADDING_2 : $PADDING_1;
        }
        else
        {
            $second = shift @letters;
        }

        push @digrams, [ $first, $second ];
    }

    return @digrams;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $key     = '';
    my $text    = '';
    my $decrypt =  0;

    GetOptions(
                  'key=s'   => \$key,
                  'text=s'  => \$text,
                  'decrypt' => \$decrypt,

              )       or error( 'Invalid command line argument(s)' );

    length $key  >  0 or error( 'Missing key' );
    length $text >  0 or error( 'Missing text' );
    scalar @ARGV == 0 or error( 'Found unexpected command line argument(s)' );

    return ($key, $text, $decrypt);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
