#!perl

###############################################################################
=comment

Perl Weekly Challenge 112
=========================

TASK #2
-------
*Climb Stairs*

Submitted by: Mohammad S Anwar

You are given $n steps to climb

Write a script to find out the distinct ways to climb to the top. You are
allowed to climb either 1 or 2 steps at a time.

Example

 Input: $n = 3
 Output: 3

     Option 1: 1 step + 1 step + 1 step
     Option 2: 1 step + 2 steps
     Option 3: 2 steps + 1 step

 Input: $n = 4
 Output: 5

     Option 1: 1 step + 1 step + 1 step + 1 step
     Option 2: 1 step + 1 step + 2 steps
     Option 3: 2 steps + 1 step + 1 step
     Option 4: 1 step + 2 steps + 1 step
     Option 5: 2 steps + 2 steps

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

It is not clear from the Task description whether the requirement is for

    (1) details of all the distinct ways to climb to the top,
or just
    (2) the total number of these distinct ways.

I have therefore provided both solutions, defaulting to (2) unless the option "--show-steps" is provided on the command line.

Algorithms
----------
(1) The number of distinct solutions for n is simply the (n + 1)th Fibonacci
    number. A straightforward calculation is provided for this.

(2) Display of the distinct solutions is performed in 3 stages:

    (a) Strings are constructed representing the possible combinations of '1'
        and '2' digits in each solution. For example, for n = 4, the strings
        are '1111', '112', and '22'.

    (b) Each string constructed in (a) is permuted into all of its possible
        digit arrangements. For example, the string '112' is permuted to '112',
        '121', and '211'.

    (c) Each permutation calculated in (b) is decoded and displayed as a
        sequence of steps. For example, '211' is displayed as:
            "Option 4: 2 steps + 1 step  + 1 step"

Note that the permutations in (b) are calculated using the NextPermute() sub-
routine from the CPAN module Algorithm::Loops.

=cut
#==============================================================================

use strict;
use warnings;
use Algorithm::Loops qw( NextPermute );
use Const::Fast;
use Getopt::Long;
use Regexp::Common   qw( number );

const my $USAGE =>
"Usage:
  perl $0 [--show-steps] <n>

    <n>             The number of steps to climb
    --show-steps    Display all the distinct ways to climb?\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 112, Task #2: Climb Stairs (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($n, $show_steps) = parse_command_line();

    print "Input:  \$n = $n\n";

    if ($show_steps)
    {
        show_steps( $n );
    }
    else
    {
        printf "Output: %d\n", fibonacci( $n + 1 );
    }
}

#------------------------------------------------------------------------------
sub show_steps
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    # (a) Construct strings to represent the possible combinations of '1' and
    #     '2' digits in a solution

    my   @steps;
    push @steps, ('1' x ($n - 2 * $_)) . ('2' x $_) for 0 .. int( $n / 2 );

    # (b) Permute each string constructed in (a) into all the possible distinct
    #     arrangements of its digits

    my @options;

    for my $step (@steps)
    {
        my @list = split '', $step;

        do
        {
            push @options, join( '', @list );

        } while (NextPermute( @list ));
    }

    # (c) Decode each permutation calculated in (b) and display it as a
    #     sequence of steps

    printf "Output: %d\n\n", scalar @options;

    my $count = 0;
    my $width = length scalar @options;

    for my $option (@options)
    {
        printf '    Option %*d: ', $width, ++$count;

        my $step = substr $option, 0, 1;

        printf '%d step%s', $step, $step == 1 ? ' ' : 's';

        for my $i (1 .. length( $option ) - 1)
        {
            $step = substr $option, $i, 1;

            printf ' + %s step%s', $step, $step eq '1' ? ' ' : 's';
        }

        print "\n";
    }
}

#------------------------------------------------------------------------------
# Return the nth Fibonacci number:
#         n   0, 1, 2, 3, 4, 5, 6,  7,  8,  9, 10, 11,  12, ...
#     fib(n)  0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...
#
sub fibonacci
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    $n >= 0 or die "Negative Fibonacci numbers are not supported\n";

    return 0 if $n == 0;
    return 1 if $n == 1 || $n == 2;

    my ($p, $q) = (1, 1);
    my  $fib;

    for (1 .. $n - 2)
    {
        $fib = $p + $q;
        $p   = $q;
        $q   = $fib;
    }

    return $fib;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $show_steps;

    GetOptions( 'show-steps' => \$show_steps )
               or error( 'Invalid command line argument(s)' );

    my $args = scalar @ARGV;
       $args == 1
               or error( "Expected 1 command line argument, found $args" );

    my $n =  $ARGV[ 0 ];
       $n =~ / ^ $RE{num}{int} $/x
               or error( qq["$n" is not an integer] );
       $n >  0 or error( qq["$n" is not greater than zero] );

    return ($n, $show_steps);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
