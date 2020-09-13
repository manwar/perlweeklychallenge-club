#!perl

###############################################################################
=comment

Perl Weekly Challenge 077
=========================

Task #1
-------
*Fibonacci Sum*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

UPDATE: 2020-09-07 09:00:00
Write a script to find out all possible combination of Fibonacci Numbers
required to get $N on addition.

You are *NOT* allowed to repeat a number. Print 0 if none found.

Example 1:

 Input: $N = 6

 Output:
     1 + 2 + 3 = 6
     1 + 5 = 6

Example 2:

 Input: $N = 9

 Output:
     1 + 8 = 9
     1 + 3 + 5 = 9

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----

The Fibonacci numbers are: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...
[1],[2], but for this Task they are taken to be:  1, 2, 3, 5, 8, 13, 21, ...
--i.e., 0 is excluded, and 1 is included only once. So the Task may be restated
as follows: find all distinct subsets of the set { 1, 2, 3, 4, 8, 13, 21, ... }
such that the sum of their members equals $N.

Note also that "positive integer" is taken to mean "Natural number", i.e., an
integer > 0, so the case of $N = 0 is excluded.

I have not found any value for $N which produces an empty solution set.

Memoization: For small values of $N, the calculation is already fast and memoi-
zation has little effect. But for larger values, the speedup is significant.
For example, with $N = 98,765,432 (2,218 combinations):

    ------------------------------------------------------------
                           Rec. calls   Time (s)   Cache (bytes)
    ------------------------------------------------------------
    Without memoization:      453,275      22.12          --
    With    memoization:           30       0.15      13,890,979
    ------------------------------------------------------------

or with $N = 987,654,321 (4,997 combinations):

    ------------------------------------------------------------
                           Rec. calls   Time (s)   Cache (bytes)
    ------------------------------------------------------------
    Without memoization:    6,692,527     275.00          --
    With    memoization:           35       0.23      30,212,067
    ------------------------------------------------------------

[1] https://oeis.org/A000045
[2] https://en.wikipedia.org/wiki/Fibonacci_number 

=cut
#==============================================================================

                                                    # Exports:
use strict;
use warnings;
use Const::Fast;                                    # const()
use Getopt::Long;                                   # GetOptions()
use List::MoreUtils qw( firstidx lastidx none );
use Memoize;                                        # memoize()
use Regexp::Common  qw( number );                   # %RE{num}

#------------------------------------------------------------------------------
# Constant
#------------------------------------------------------------------------------

const my $USAGE =>
"Usage:
  perl $0 [--hide-sums] <N>

    <N>            The target sum (a positive integer)
    --hide-sums    Suppress display of all the distinct combinations?\n";

#------------------------------------------------------------------------------
# File-local variables
#------------------------------------------------------------------------------

my @f_Fibonacci;    # Fibonacci numbers: 1, 2, 3, 5, 8, 13, ...
my %f_Cum_sums;     # Fibonacci numbers (keys) and their cumulative sums (vals)

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 077, Task #1: Fibonacci Sum (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($N, $hide_sums) = parse_command_line();

    init_fib_nums($N);

    memoize('find_fib_sums');

    my @sums = find_fib_sums($N);

    display_results($N, \@sums, $hide_sums);
}

#------------------------------------------------------------------------------
sub find_fib_sums                                        # Recursive subroutine
#------------------------------------------------------------------------------
{
    my ($N) = @_;
    my  @terms;

    if    ($N == 0)                    # Base case  (a):       0 --> empty sum
    {
        @terms = ( [] );
    }
    elsif ($N <= 2)                    # Base cases (b) & (c): 1 --> 1, 2 --> 2
    {
        @terms = ( [$N] );
    }
    else                               # Recursive cases
    {
        my $max  = lastidx  {             $_  <= $N } @f_Fibonacci;
        my $min  = firstidx { $f_Cum_sums{$_} >= $N } @f_Fibonacci;

        for my $f (reverse @f_Fibonacci[$min .. $max])
        {
            my @prev_terms = find_fib_sums($N - $f);
            my @new_terms;

            for my $t (@prev_terms)
            {
                if (none { $_ == $f } @$t)
                {
                    # N.B. Can't push to @$t, because $t (an array reference)
                    # is already entered in the memoization cache; pushing to
                    # @$t corrupts the cache data

                    push @new_terms, [@$t, $f];
                }
              # else:  $f is already present in @$t, so omit $t from @new_terms
            }

            push @terms, @new_terms;
        }
    }

    return @terms;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $hide_sums = 0;

    GetOptions
    (
        'hide-sums' => \$hide_sums,

    )                    or die "ERROR in command line arguments\n$USAGE";

    my $args = scalar @ARGV;
       $args == 1        or die "ERROR: Found $args command-line arguments, " .
                                "expected 1\n$USAGE";

    my $N = $ARGV[0];
       $N =~ /\A$RE{num}{int}\z/
                         or die "ERROR: \$N ($N) must be an integer\n$USAGE";
       $N > 0            or die "ERROR: \$N ($N) must be > 0\n$USAGE";

    return ($N, $hide_sums);
}

#------------------------------------------------------------------------------
sub init_fib_nums
#------------------------------------------------------------------------------
{
    @f_Fibonacci = (1, 2);
    %f_Cum_sums  = (1 => 1, 2 => 3);

    my ($N)      =  @_;
    my  $fib     =  2;
    my  $sum     =  3;

    until ($fib >= $N)
    {
        $fib = $f_Fibonacci[-2] + $f_Fibonacci[-1];

        push @f_Fibonacci, $fib;

        $sum += $fib;

        $f_Cum_sums{ $fib } = $sum;
    }
}

#------------------------------------------------------------------------------
sub display_results
#------------------------------------------------------------------------------
{
    my ($N, $sums, $hide_sums) = @_;
    my  $count = scalar @$sums;

    printf "Input: \$N = %d\n\n" .
           "Output: %d %scombination%s of Fibonacci numbers sum%s to %d%s\n",
            $N, $count, $count == 1               ? ''  : 'different ',
                        $count == 1               ? ''  : 's',
                        $count == 1               ? 's' : '',
                    $N, $count == 0 || $hide_sums ? ''  : ':';

    unless ($hide_sums)
    {
        printf "    %s = %d\n", join(' + ', sort { $a <=> $b } @$_), $N
            for @$sums;
    }
}

###############################################################################
