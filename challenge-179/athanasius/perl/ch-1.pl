#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------
1. Ordinal names use the short scale. [1]
2. Valid input is any integer $n in the range 0 < $n <= (2^64 - 2^10).

Interface
---------
If $n is not supplied on the command line, the in-file test suite is run
instead.

Note
----
Script output tested under Windows 8.1 using Perl v5.32.1.

Reference
---------
[1] "Long and short scales", Wikipedia,
     https://en.wikipedia.org/wiki/Long_and_short_scales

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $MAX   => 18_446_744_073_709_550_592;                    # 2^64 - 2^10

const my %UNITS =>
(
    CARDINAL    =>
    [ '', qw( one   two    three four   five  six   seven   eight  nine  ) ],
    ORDINAL     =>
    [ '', qw( first second third fourth fifth sixth seventh eighth ninth ) ],
);

const my @TEENS => qw( ten     eleven  twelve    thirteen fourteen
                       fifteen sixteen seventeen eighteen nineteen );

const my @TENS  => '', '', qw( twenty thirty  forty  fifty
                               sixty  seventy eighty ninety );

const my @LARGE => qw( thousand million     billion
                       trillion quadrillion quintillion );

const my $USAGE =>
"Usage:
  perl $0 <n>
  perl $0

    <n>    A natural number below 2^64 - 2^10\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 179, Task #1: Ordinal Number Spelling (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n = parse_command_line();

    if (defined $n)
    {
        printf "Input:  %s\n", add_commas( $n );
        printf "Output: %s\n", ordinal   ( $n );
    }
    else
    {
        run_tests();
    }
}

#------------------------------------------------------------------------------
sub ordinal
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    $n = '0' x ((3 - (length( $n ) % 3)) % 3) . $n;  # Prepend zeroes

    my @triples  = $n =~ / (\d{3}) /gx;              # Group digits
    my $ls_digs  = $triples[ -1 ];                   # Least significant digits
    my $hundreds = hundreds( pop @triples, 1 );

    my   @ordinal;
    push @ordinal, $hundreds if $hundreds;

    for (my $index = 0; @triples; ++$index)
    {
        if ((my $n = pop @triples) > 0)
        {
            push @ordinal, hundreds( $n, 0 ) . ' ' . $LARGE[ $index ];
        }
    }

    return format_ordinal( \@ordinal, $ls_digs );
}

#------------------------------------------------------------------------------
sub hundreds
#------------------------------------------------------------------------------
{
    my ($n, $ordinal)     = @_;
    my ($hundreds, $tens) = $n =~ / ^ (\d) (\d{2}) $ /x;
    my  $name             = tens( $tens, $ordinal );

    if ($hundreds > 0)
    {
        $name = $UNITS{ CARDINAL }[ $hundreds ] . ' hundred' .
                (($tens == 0) ? '' : ($name ? " and $name" : 'th'));
    }

    return $name;
}

#------------------------------------------------------------------------------
sub tens
#------------------------------------------------------------------------------
{
    my ($n, $ordinal) = @_;

    return '' if $n == 0;

    my ($tens, $units) = $n =~ / ^ (\d) (\d) $ /x;

    my  $key  =  $ordinal    ? 'ORDINAL' : 'CARDINAL';
    my  $name = ($tens == 1) ? $TEENS[ $units ] . ($ordinal ? 'th' : '')
                             : $UNITS{ $key }[ $units ];

    if ($tens > 1)
    {
        my $tens_name = $TENS[ $tens ];

        if    ($units > 0)
        {
            $name = $tens_name . '-' . $name;
        }
        elsif ($ordinal)
        {
            $name = substr( $tens_name, 0, -1 ) . 'ieth';
        }
        else
        {
            $name = $tens_name;
        }
    }

    return $name;
}

#-------------------------------------------------------------------------------
sub format_ordinal
#-------------------------------------------------------------------------------
{
    my ($ord_array, $ls_digs) = @_;
    my  $ordinal;

    if    (scalar @$ord_array == 1)
    {
        $ordinal = $ord_array->[ 0 ] . (($ls_digs % 100 == 0) ? 'th' : '');
    }
    elsif ($ls_digs % 100 == 0)
    {
        $ordinal = join( ' ', reverse @$ord_array ) . 'th';
    }   
    elsif ($ls_digs =~ / ^ 0 /x)
    {
        $ordinal = join( ' ', reverse @$ord_array[ 1 .. $#$ord_array ] ) .
                   ' and ' . $ord_array->[ 0 ];
    }
    else
    {
        $ordinal = join ' ', reverse @$ord_array;
    }

    return $ordinal;
}

#-------------------------------------------------------------------------------
sub add_commas
#-------------------------------------------------------------------------------
{
    my ($number) = @_;

    # Regex from perlfaq5: "How can I output my numbers with commas added?"

    return $number =~ s/(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/gr;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 0 and return;           # Run tests
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

    $n >  0       or error( "$n is not a natural number" );

    $n <= $MAX    or error( "$n is too large" );

    return $n + 0;                      # Normalise (remove any initial zeroes)
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    while (my $line = <DATA>)
    {
        chomp $line;

        $line =~ s/ ^ (\s+) //x;                    # Remove initial whitespace

        my ($n, $expected) = split /\s+/, $line, 2;
        my  $test_name     = sprintf '(%s)', add_commas( $n );

        is ordinal( $n ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
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
18446744073709550592 eighteen quintillion four hundred and forty-six quadrillion seven hundred and forty-four trillion seventy-three billion seven hundred and nine million five hundred and fifty thousand five hundred and ninety-second
