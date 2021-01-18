#!perl

###############################################################################
=comment

Perl Weekly Challenge 095
=========================

Task #1
-------
*Palindrome Number*

Submitted by: Mohammad S Anwar (http://www.manwar.org)

You are given a number $N.

Write a script to figure out if the given number is Palindrome. Print 1 if true
otherwise 0.

Example 1:

 Input: 1221
 Output: 1

Example 2:

 Input: -101
 Output: 0, since -101 and 101- are not the same.

Example 3:

 Input: 90
 Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<N>]

    [<N>]    A real number to be tested: is it a palindrome?\n";

const my @TESTS =>
         (
             {
                 input       =>  1221,
                 expected    =>  1,
                 description => 'Example 1',
             },
             {
                 input       => -101,
                 expected    =>  0,
                 description => 'Example 2',
             },
             {
                 input       =>  90,
                 expected    =>  0,
                 description => 'Example 3',
             },
             {
                 input       =>  1234.4321,
                 expected    =>  1,
                 description => 'Decimal 1',
             },
             {
                 input       =>  1234.04321,
                 expected    =>  0,
                 description => 'Decimal 2',
             },
         );

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 095, Task #1: Palindrome Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        test();
    }
    elsif ($args == 1)
    {
        my $N = $ARGV[0];
           $N =~ / ^ $RE{num}{real} $ /x
                  or die "ERROR: $N is not a number\n$USAGE";

        printf "Input:  %s\nOutput: %d\n", $N, is_palindrome($N) ? 1 : 0;
    }
    else
    {
        die "ERROR: Too many command-line arguments\n$USAGE";
    }
}

#------------------------------------------------------------------------------
sub is_palindrome
#------------------------------------------------------------------------------
{
    my ($N)     = @_;
    my  @chars  = split //, $N;
    my  $is_pal = 1;

    for my $i (0 .. int($#chars / 2))
    {
        if ($chars[$i] ne $chars[$#chars - $i])
        {
            $is_pal = 0;
            last;
        }
    }

    return $is_pal;
}

#------------------------------------------------------------------------------
sub test
#------------------------------------------------------------------------------
{
    use Test::More;
    plan tests => scalar @TESTS;

    for my $test (@TESTS)
    {
        my $got = is_palindrome( $test->{input} );

        is $got, $test->{expected}, $test->{description};
    }
}

###############################################################################
