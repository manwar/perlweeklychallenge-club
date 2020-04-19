#!perl

################################################################################
=comment

Perl Weekly Challenge 056
=========================

Task #1
-------
*Diff-K*

You are given an array *@N* of positive integers (sorted) and another non
negative integer *k*.

Write a script to find if there exists 2 indices *i* and *j* such that
*A[i] - A[j] = k* and *i != j*.

It should print the pairs of indices, if any such pairs exist.

Example:

    @N = (2, 7, 9)
    $k = 2

Output : 2,1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Data::Util qw( is_integer );
use Getopt::Long;

const my $USAGE => "USAGE: perl $0 --k=<K> <L> <M> <N> ...\n"  . ' ' x 20 .
                   "- where     K is a non-negative integer\n" . ' ' x 20 .
                   "  and L, M, N, ... are positive integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 056, Task #1: Diff-K (Perl)\n\n";

    # 1. Get, validate, and print @N and K

    my ($n, $k) = parse_command_line();

    printf "\@N = (%s)\n K =  %d\n\n", join(', ', @$n), $k;

    # 2. Find all solutions

    my @solutions;

    for my $i (1 .. $#$n)
    {
        for my $j (0 .. $i - 1)
        {
            push @solutions, [$i, $j] if $n->[$i] - $n->[$j] == $k;
        }
    }

    # 3. Output the solutions

    my  $solutions = scalar @solutions;

    if ($solutions == 0)
    {
        print  "No solutions found\n";
    }
    else
    {
        printf "Found %d solution%s: %s\n",
                $solutions, $solutions == 1 ? '' : 's',
                join ', ', map "($_->[0], $_->[1])", @solutions;
    }
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $k;
    GetOptions('k=i' => \$k) or error();
    defined $k               or error('K is missing on the command line');
    $k >= 0                  or error('K must be non-negative');

    my     @n = @ARGV;
    scalar @n > 0            or error('The array is empty');

    is_integer($_) && $_ > 0 or error("Invalid array value '$_'") for @n;

    @n = sort { $a <=> $b } @n;

    return (\@n, $k);
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($msg) = @_;

    die defined $msg ? "ERROR: $msg\n$USAGE" : $USAGE;
}

################################################################################
