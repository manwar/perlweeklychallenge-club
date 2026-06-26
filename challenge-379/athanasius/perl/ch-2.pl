#!perl

################################################################################
=comment

Perl Weekly Challenge 379
=========================

TASK #2
-------
*Armstrong Number*

Submitted by: Mohammad Sajid Anwar

You are given two integers, $base and $limit.

Write a script to find all Armstrong numbers in base $base that are less than
$limit.

  If raising each of the digits of a nonnegative integer to the power of the
  total number of digits, then taking the sum, equals the original number, it is
  an Armstrong number.

Example 1

  Input: $base = 10, $limit = 1000
  Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407)

Example 2

  Input: $base = 7, $limit = 1000
  Output: (0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250)

Example 3

  Input: $base = 16, $limit = 1000
  Output: (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520,
  584, 645)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. $base is a positive integer greater than 1.
2. $base is no greater than 36. This is the maximum base that can be represented
   by the digits 0 to 9 together with the letters A to Z.
3. $limit is an unsigned integer.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two unsigned integers, $base and $limit, are entered on the command-line.
   $base must be between 2 and 36, inclusive.
3. If desired, the command-line arguments are preceded by a "-s" flag to signal
   that the output (which is in decimal) is to be repeated in the given base.

Reference
---------
Wikipedia contributors. Narcissistic number [Internet]. Wikipedia, The Free
Encyclopedia; 2025 Sep 30, 19:38 UTC [cited 2026 Jun 24]. Available from:
https://en.wikipedia.org/w/index.php?title=Narcissistic_number&oldid=1314314515

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util          qw( min sum0 );
use Math::Base::Convert qw( dec );
use Regexp::Common;
use Test::More;

const my @SYMBOLS  => '0' .. '9', 'A' .. 'Z';
const my $MAX_BASE => scalar @SYMBOLS;
const my $USAGE    => <<END;
Usage:
  perl $0 [-s|--show_in_base] <base> <limit>
  perl $0

    <base>               Number base of Armstrong numbers (from 2 to $MAX_BASE)
    <limit>              Upper limit of Armstrong numbers
    -s|--show_in_base    Show output in the given \$base? [default: False]
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 379, Task #2: Armstrong Number (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $show_in_base;

    GetOptions( show_in_base => \$show_in_base )
        or error( 'Invalid command line argument(s)' );

    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my ($base, $limit) = @ARGV;
        my  $msg = validate_args( $base, $limit );

        error( $msg ) if $msg;

        print  "Input:  \$base = $base, \$limit = $limit\n";

        my ($d2b, $b2d) = get_base_converters( $base );
        my  $armstrong  = find_armstrong_nums( $base, $limit, $d2b, $b2d );

        printf "Output: (%s)\n", join ', ', @$armstrong;
        printf "      = (%s) (base $base)\n", join ', ',
                grep { length > 0 } map { $d2b->cnv( $_ ) } @$armstrong
                    if $show_in_base && $base != 10;
    }
    else
    {
        error( "Expected 2 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_armstrong_nums
#-------------------------------------------------------------------------------
{
    my ($base, $limit, $d2b, $b2d) = @_;
    my  $msg = validate_args( $base, $limit );

    die "$msg, stopped" if $msg;

    my @armstrong;
    my @powers = 0 .. $base - 1;                    # Exponent 1
    my $n      = 0;
    my $end    = min $base, $limit;

    push @armstrong, $n++ while $n < $end;

    for (my $exp = 2; $n < $limit; ++$exp)
    {
        $powers[ $_ ] *= $_ for 0 .. $base - 1;     # Exponent 2+

        $end = min $base ** $exp, $limit;

        while (++$n < $end)
        {
            my @digits = ($base == 10) ? split //, $n :
                          grep { length > 0 }
                          map  { $b2d->cnv( $_ ) } split //, $d2b->cnv( $n );
            my $sum    =  sum0 @powers[ @digits ];

            push @armstrong, $n if $n == $sum;
        }
    }

    return \@armstrong;
}

#-------------------------------------------------------------------------------
sub validate_args
#-------------------------------------------------------------------------------
{
    # Returns the empty string on success, an error message on failure

    my  ($base, $limit) = @_;

    for ($base, $limit)
    {
        return qq["$_" is not a valid integer] unless / ^ $RE{num}{int} $ /x;
        return "$_ is negative"                unless $_ > 0;
    }

    return (1 < $base <= $MAX_BASE) ? '' : "Invalid base $base";
}

#-------------------------------------------------------------------------------
sub get_base_converters
#-------------------------------------------------------------------------------
{
    my ($base)    = @_;
    my  $base_ref = [ @SYMBOLS[ 0 .. $base - 1 ] ];
    my  $d2b      = Math::Base::Convert->new( dec, $base_ref );
    my  $b2d      = Math::Base::Convert->new( $base_ref, dec );

    return ($d2b, $b2d);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            chomp $line;
            $line =~ s/ \s* \\ $ / /gx;
            $line .= <DATA>;
        }

        my  ($test_name, $base, $limit, $exp_str) = split / \| /x, $line;

        for ($test_name, $base, $limit, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($d2b, $b2d) = get_base_converters( $base );
        my  $armstrong  = find_armstrong_nums( $base, $limit, $d2b, $b2d );
        my  @expected   = split / \s+ /x, $exp_str;

        is_deeply $armstrong, \@expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|10|1000|0 1 2 3 4 5 6 7 8 9 153 370 371 407
Example 2| 7|1000|0 1 2 3 4 5 6 10 25 32 45 133 134 152 250
Example 3|16|1000|0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 342 371 520 584 645
Base 12  |12|2700|0 1 2 3 4 5 6 7 8 9 10 11 29 125 811 944 1539
Base 36  |36|5500|0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23\
                  24 25 26 27 28 29 30 31 32 33 34 35 5489
