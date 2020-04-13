#!perl

################################################################################
=comment

Perl Weekly Challenge 055
=========================

Task #1
*Flip Binary*

You are given a binary number *B*, consisting of *N* binary digits *0* or *1*:
*s0, s1, …, s(N-1)*.

Choose two indices *L* and *R* such that *0 ≤ L ≤ R < N* and flip the digits
*s(L), s(L+1), …, s(R)*. By flipping, we mean change *0* to *1* and vice-versa.

For example, given the binary number 010, the possible flip pair results are
listed below:

  ▪ L=0, R=0 the result binary: 110
  ▪ L=0, R=1 the result binary: 100
  ▪ L=0, R=2 the result binary: 101
  ▪ L=1, R=1 the result binary: 000
  ▪ L=1, R=2 the result binary: 001
  ▪ L=2, R=2 the result binary: 011

Write a script to find the indices (*L,R*) that results in a binary number with
maximum number of *1*s. If you find more than one maximal pair *L,R* then print
all of them.

Continuing our example, note that we had three pairs *(L=0, R=0)*, *(L=0, R=2)*,
and *(L=2, R=2)* that resulted in a binary number with two *1*s, which was the
maximum. So we would print all three pairs.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use constant DEBUG => 0;

const my $USAGE => "USAGE: perl $0 <B> - where B is a binary number\n";

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
    print "Challenge 055, Task #1: Flip Binary (Perl)\n\n";

    @ARGV == 1 or die $USAGE;

    my @binary = split //, $ARGV[0];

    $_ eq '0' || $_ eq '1'
        or die "ERROR: Found \"$_\", expected \"0\" or \"1\"\n$USAGE"
            for @binary;

    my  ($max, $indices) = solve(\@binary);
    my   @pairs;
    push @pairs, "($_->[0], $_->[1])" for @$indices;

    printf "The maximum number of 1s obtained by flipping \"%s\" is %d,\n" .
           "obtained with the flip indices: %s\n", $ARGV[0], $max,
            join ', ', @pairs;
}

#-------------------------------------------------------------------------------
sub solve
#-------------------------------------------------------------------------------
{
    my ($binary) = @_;
    my  $max_i   = scalar(@$binary) - 1;
    my  %results;

    for my $left (0 .. $max_i)
    {
        for my $right ($left .. $max_i)
        {
            my $flipped = flip($binary, $left, $right);
            my $ones    = count_1s($flipped);

            push $results{$ones}->@*, [$left, $right];
        }
    }

    my $max = (sort { $a <=> $b } keys %results)[-1];

    return ($max, $results{$max});
}

#-------------------------------------------------------------------------------
sub flip
#-------------------------------------------------------------------------------
{
    my ($binary, $left, $right) = @_;

    if (DEBUG)
    {
        my $n = scalar @$binary;

        die "INVALID parameters to flip()\n"
            unless $left >= 0 && $left <= $right && $left < $n && $right < $n;
    }

    my @flipped = @$binary;

    for my $i ($left .. $right)
    {
        my $digit    = $flipped[$i];
        $flipped[$i] = $digit == 0 ? 1 : 0;
    }

    return \@flipped;
}

#-------------------------------------------------------------------------------
sub count_1s
#-------------------------------------------------------------------------------
{
    my ($binary) = @_;
    my  $count   = 0;

    $_ == 1 && ++$count for @$binary;

    return $count;
}

################################################################################
