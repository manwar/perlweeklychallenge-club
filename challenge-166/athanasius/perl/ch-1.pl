#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;

const my $DICTIONARY  => '../../../data/dictionary.txt';
const my $HEX_LETTERS => 'ABCDEF';
const my %HEX_NUMBERS => ( I => '1', L => '1', O => '0', S => '5', T => '7' );
const my $LETTERS     => $HEX_LETTERS . join '', sort keys %HEX_NUMBERS;
const my $MIN_LETTERS => 2;
const my $MAX_LETTERS => 8;
const my $USAGE       =>
"Usage:
  perl $0 [--max[=Int]] [--prop[=Real]] [--single] [--phrases]

    --max[=Int]      Maximum digits in word
    --prop[=Real]    Maximum proportion of digits
    --single         Disallow '1' as both 'I' & 'L' [default: False]
    --phrases        Find 8-letter phrases          [default: False]\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 166, Task #1: Hexadecimal Words (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($max_nums, $max_prop, $single_def_1, $phrases) = parse_command_line();

    my $table_re = join '|', sort keys %HEX_NUMBERS;
    my @words;

    open my $fh, '<', $DICTIONARY
        or die qq[Cannot open file "$DICTIONARY" for reading, stopped];

    while (my $line = <$fh>)
    {
        chomp $line;
        my    $word   = ucfirst $line;
        my    $length = length  $word;

        if ($MIN_LETTERS <= $length <= $MAX_LETTERS &&
            $word =~ / ^ [$LETTERS]+ $ /ix)
        {
            my $hex = test_word( $word, $table_re, $max_nums, $max_prop,
                                 $single_def_1 );

            push @words, [ $word, $hex ] if defined $hex;
        }
    }

    close $fh
        or die qq[Cannot close file "$DICTIONARY", stopped];

    display_words( $phrases ? find_phrases( \@words ) : \@words );
}

#------------------------------------------------------------------------------
sub find_phrases
#------------------------------------------------------------------------------
{
    my ($words) = @_;
    my  %len2words;

    for my $word (@$words)
    {
        push @{ $len2words{ length $word->[ 0 ] } }, $word;
    }

    my @phrases = @{ $len2words{ $MAX_LETTERS } };

    for my $i (2 .. int( $MAX_LETTERS / 2 ))
    {
        my $j = $MAX_LETTERS - $i;

        for my $word_i (@{ $len2words{ $i } })
        {
            for my $word_j (@{ $len2words{ $j } })
            {
                push @phrases, [ $word_i->[ 0 ] . $word_j->[ 0 ],
                                 $word_i->[ 1 ] . $word_j->[ 1 ] ];
            }
        }
    }

    return \@phrases;
}

#------------------------------------------------------------------------------
sub test_word
#------------------------------------------------------------------------------
{
    my ($word, $table_re, $max_nums, $max_prop, $single_def_1) = @_;

    if ($single_def_1)
    {
        return if $word =~ / I /ix && $word =~ / L /ix;
    }

    my $hex  = $word =~ s/ ($table_re) /$HEX_NUMBERS{ uc $1 }/girx;
    my $from = uc( $HEX_LETTERS ) . lc( $HEX_LETTERS );
    my $nums = length eval "\$hex =~ tr/$from//dr";

    return if (defined $max_nums && $nums > $max_nums) ||
              (defined $max_prop && $nums / length( $hex ) > $max_prop);

    my $ch0 = substr $hex, 0, 1;

    substr $hex, 0, 1, uc( $ch0 ) if $ch0 =~ / [$HEX_LETTERS] /ix;

    return $hex;
}

#------------------------------------------------------------------------------
sub display_words
#------------------------------------------------------------------------------
{
    my ($words) = @_;

    print "  Word      Hex\n";
    print "  --------------------\n";

    for my $word (@$words)
    {
        printf "  %-8s  0x%-10s\n", $word->[ 0 ], $word->[ 1 ];
    }

    print  "  --------------------\n";
    printf "  Count: %d\n", scalar @$words;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my ($max_numbers, $max_proportion);
    my  $single_def_1 = 0;
    my  $find_phrases = 0;

    GetOptions
    (
        'max=i'   => \$max_numbers,
        'prop=f'  => \$max_proportion,
        'single'  => \$single_def_1,
        'phrases' => \$find_phrases,

    )       or error( 'Error in command line arguments' );

    my $args = scalar @ARGV;
       $args == 0
            or error( "Expected 0 command line arguments, found $args" );

    if (defined $max_numbers)
    {
        0 <= $max_numbers    <= $MAX_LETTERS
            or error( qq[Invalid value "$max_numbers" for max] );
    }

    if (defined $max_proportion)
    {
        0 <= $max_proportion <= 1
            or error( qq[Invalid value "$max_proportion" for prop] );
    }

    return ($max_numbers, $max_proportion, $single_def_1, $find_phrases);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
