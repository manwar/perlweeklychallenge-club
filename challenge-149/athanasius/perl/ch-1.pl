#!perl

###############################################################################
=comment

Perl Weekly Challenge 149
=========================

TASK #1
-------
*Fibonacci Digit Sum*

Submitted by: Roger Bell_West

Given an input $N, generate the first $N numbers for which the sum of their
digits is a Fibonacci number.

Example

 f(20)=[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41,
        44]

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
The natural numbers are searched sequentially. For each number $i, the digits
are summed and the sum is tested to discover whether it is a Fibonacci number.
If it is, it is printed and the count is incremented. The search stops when the
required number of solutions have been found.

The is_fib() function, which determines whether a given number is a Fibonacci
number, keeps track of known Fibonacci numbers in a hash. (A hash is used for
ease of look-up.) Whenever the input number is greater than the largest known
Fibonacci number, new Fibonacci numbers are generated and stored. This step
proceeds in increments of $FIB_INC new Fibonacci numbers at a time. The value
of the constant $FIB_INC may be adjusted according to the expected size(s) of
the command-line input $N: for larger values of $N, larger values of $FIB_INC
may be expected to produce more efficient results.

=cut
#==============================================================================

use strict;
use warnings;
use feature        qw( state );
use Const::Fast;
use Regexp::Common qw( number );

const my $FIB_INC => 10;
const my $USAGE   =>
"Usage:
  perl $0 <N>

    <N>    Natural number: required output count\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 149, Task #1: Fibonacci Digit Sum (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "f($N) = [0";

    for (my ($count, $i) = (1, 1); $count < $N; ++$i)
    {
        my $sum  = 0;
           $sum += $_ for split '', $i;

        if (is_fib( $sum ))
        {
            print ", $i";

            ++$count;
        }
    }

    print "]\n";
}

#------------------------------------------------------------------------------
sub is_fib
#------------------------------------------------------------------------------
{
    state %fib = (0 => undef, 1 => undef);
    state $max =  1;
    state $f2  =  0;
    state $f1  =  1;

    my ($n) = @_;

    while ($max < $n)
    {
        for (1 .. $FIB_INC)
        {
            ($f2, $f1)  = ($f1, $f2 + $f1);

            $fib{ $f1 } = undef;
        }

        $max += $FIB_INC;
    }

    return exists $fib{ $n };
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $N = $ARGV[ 0 ];

    $N =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$N" is not a valid integer] );

    $N > 0        or error( qq["$N" is not positive] );

    return $N;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
