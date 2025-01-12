#!perl

################################################################################
=comment

Perl Weekly Challenge 303
=========================

TASK #1
-------
*3-digits Even*

Submitted by: Mohammad Sajid Anwar

You are given a list (3 or more) of positive integers, @ints.

Write a script to return all even 3-digits integers that can be formed using the
integers in the given list.

Example 1

  Input: @ints = (2, 1, 3, 0)
  Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)

Example 2

  Input: @ints = (2, 2, 8, 8, 2)
  Output: (222, 228, 282, 288, 822, 828, 882)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. Although only 1-digit integers are used in the examples, the input integers
   may have any number of digits.
2. A 3-digit number cannot start with digit 0.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Three or more unsigned integers are entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( uniqint );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of 3 or more unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 303, Task #1: 3-digits Even (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc >= 3)
    {
        my @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >= 0                or error( "$_ is not positive" );
        }

        printf "Input: \@ints = (%s)\n", join ', ', @ints;

        my $nums =  find_three_digit_even_numbers( \@ints );

        printf "Output:        (%s)\n",  join ', ', @$nums;
    }
    else
    {
        error( "Expected 0 or 3+ command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_three_digit_even_numbers
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my (%nums, @dig1, @dig2, @dig3);

    sort_ints( $ints, \@dig1, \@dig2, \@dig3 );         # Discard 4+ digit nums

    combine_single_digits( \@dig1, \%nums );            # (a)(b)(c)

    @$_ = uniqint @$_ for \( @dig1, @dig2, @dig3 );     # Remove duplicates

    for my $rhs (grep { $_ % 2 == 0 } @dig1)            # (ab)(c)
    {
        ++$nums{ $_ *  10 + $rhs } for @dig2;
    }

    for my $rhs (grep { $_ % 2 == 0 } @dig2)            # (a)(bc)
    {
        ++$nums{ $_ * 100 + $rhs } for @dig1;
    }

    ++$nums{ $_ } for grep { $_ % 2 == 0 } @dig3;       # (abc)

    return [ sort { $a <=> $b } keys %nums ];
}

#-------------------------------------------------------------------------------
sub sort_ints
#-------------------------------------------------------------------------------
{
    my ($ints, $dig1, $dig2, $dig3) = @_;

    for my $n (@$ints)
    {
        if    ($n <   10)           # 1 digit
        {
            push @$dig1, $n;
        }
        elsif ($n <  100)           # 2 digits
        {
            push @$dig2, $n;
        }
        elsif ($n < 1000)           # 3 digits
        {
            push @$dig3, $n;
        }
      # else                        # 4+ digits: discard
    }
}

#-------------------------------------------------------------------------------
sub combine_single_digits
#-------------------------------------------------------------------------------
{
    my ($dig1, $nums) = @_;

    for my $i (0 .. $#$dig1)
    {
        my $lhs = $dig1->[ $i ];

        next if $lhs == 0;

        for my $j (0 .. $#$dig1)
        {
            next if $i == $j;

            my $mid = $dig1->[ $j ];

            for my $k (0 .. $#$dig1)
            {
                next if $k == $i;
                next if $k == $j;

                my $rhs = $dig1->[ $k ];

                next if $rhs % 2 != 0;

                my $num = $lhs * 100 + $mid * 10 + $rhs;

                ++$nums->{ $num };
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $int_str;
        my @exp  = split / \s+ /x, $exp_str;
        my $nums = find_three_digit_even_numbers( \@ints );

        is_deeply $nums, \@exp, $test_name;
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
Example 1   |2 1 3 0    |102 120 130 132 210 230 302 310 312 320
Example 2   |2 2 8 8 2  |222 228 282 288 822 828 882
1 & 2 digits|1 7 13 24 6|124 136 176 246 624 716 724
3 digits    |123 246 980|246 980
