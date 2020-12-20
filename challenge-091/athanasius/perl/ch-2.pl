#!perl

###############################################################################
=comment

Perl Weekly Challenge 091
=========================

Task #2
-------
*Jump Game*

Submitted by: Mohammad S Anwar

You are given an array of positive numbers @N, where value at each index deter-
mines how far you are allowed to jump further.

Write a script to decide if you can jump to the last index. Print 1 if you are
able to reach the last index otherwise 0.

Example 1:

 Input: @N = (1, 2, 1, 2)
 Output: 1

 as we jump one place from index 0 and then two places from index 1 to reach
 the last index.

Example 2:

 Input: @N = (2,1,1,0,2)
 Output: 0

 it is impossible to reach the last index. as we jump two places from index 0
 to reach index 2, followed by one place jump from index 2 to reach the index
 3. once you reached the index 3, you can't go any further because you can only
 jump 0 position further.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The Task description "...value at each index determines how far you are allowed
to jump further" can be interpreted in two ways. Suppose the index is $i and
the value is $n; then, arriving at index $i, one is allowed to jump either:

(1) exactly $n indices forward; or
(2) any number of indices between 1 and $n forward, at the jumper's discretion.

As (2) is the more interesting case, I've made it the default. For (1), enter

    -e or --exact

on the command line. I've also included a

    -v or --verbose

command-line option, which displays each step of the search. For case (2),
which is solved via backtracking (implemented using recursion), the verbose
output is useful because it shows which moves failed and why, and which move
(if any) was the first to succeed.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [--exact] [--verbose] [<N> ...]

    [<N> ...]    1+ non-negative integers
    --e[xact]    Allow exact moves only
    --v[erbose]  Show the steps followed\n";

my $Verbose;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 091, Task #2: Jump Game (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($exact, @N) = parse_command_line();
    my  $result;

    printf "Input:  \@N = (%s)\n", join(', ', @N);

    if ($exact)
    {
        print "\nOnly *exact* jumps are allowed\n\n"               if $Verbose;
        $result = jump_exact(\@N);
    }
    else
    {
        print "\nThe value at each index is the *maximum* jump allowed\n\n"
                                                                   if $Verbose;
        $result = jump_up_to(\@N, 0);
    }

    print  "\n"                                                    if $Verbose;
    printf "Output: %d\n", $result ? 1 : 0;
}

#------------------------------------------------------------------------------
sub jump_exact
#------------------------------------------------------------------------------
{
    my ($N)     = @_;
    my  $result = 1;
    my  $index  = 0;

    until ($index == $#$N)
    {
        my $jump = $N->[$index];

        if ($jump == 0)
        {
            _log('Failure: jump at index %d is 0', $index);
            $result = 0;
            last;
        }

        _log('At index %d, jumping %d', $index, $jump);
        $index += $jump;

        if ($index > $#$N)
        {
            _log('Failure: reached index %d', $index);
            $result = 0;
            last;
        }
    }

    _log('Success: reached index %d', $index) if $result;

    return $result;
}

#------------------------------------------------------------------------------
sub jump_up_to                                           # Recursive subroutine
#------------------------------------------------------------------------------
{
    my ($N, $index) = @_;
    my  $result     = 0;

    if    ($index == $#$N)              # Base case 1: Success (target reached)
    {
        _log('Success: reached index %d', $index);
        $result = 1;
    }
    elsif ($index >  $#$N)              # Base case 2: Failure (jumped too far)
    {
        _log('Failure: reached index %d, backtracking...', $index);
    }
    elsif ($N->[$index] == 0)           # Base case 3: Failure (zero jump)
    {
        _log('Failure: jump at index %d is 0, ' .
             ($index ? 'backtracking...' : 'search ended'), $index);
    }
    else
    {
        for my $i (reverse 1 .. $N->[$index])             # Prefer longer jumps
        {
            _log('At index %d, jumping %d', $index, $i);

                                        # Recursive case 1: Success

            last if $result = jump_up_to($N, $index + $i);
        }

        unless ($result)                # Recursive case 2: Failure
        {
            _log('Failure: all jumps failed at index %d, ' .
                 ($index ? 'backtracking...' : 'search ended'), $index);
        }
    }

    return $result;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $exact;

    GetOptions
    (
        'exact'   => \$exact,
        'verbose' => \$Verbose,
    )                             or error( 'Invalid command-line arguments' );

    scalar @ARGV > 0              or error( 'Command-line arguments missing' );

    for (@ARGV)
    {
        / \A $RE{num}{int} \z /x  or error( qq["$_" is not an integer] );
        $_ >= 0                   or error( qq["$_" is negative] );
    }

    return ($exact, @ARGV);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub _log
#------------------------------------------------------------------------------
{
    my ($format, @args) = @_;

    printf "--$format\n", @args if $Verbose;
}

###############################################################################
