#!perl

################################################################################
=comment

Perl Weekly Challenge 053
=========================

Task #2
*Vowel Strings*

Write a script to accept an integer *1 <= N <= 5* that would print all possible
[distinct] strings of size *N* formed by using only vowels (*a, e, i, o, u*).

The string should follow the following rules:

    1. 'a' can only be followed by 'e' and 'i'.

    2. 'e' can only be followed by 'i'.

    3. 'i' can only be followed by 'a', 'e', 'o', and 'u'.

    4. 'o' can only be followed by 'a' and 'u'.

    5. 'u' can only be followed by 'o' and 'e'.

For example, if the given integer *N = 2* then script should print the following
strings:

  ae
  ai
  ei
  ia
  io
  iu
  ie
  oa
  ou
  uo
  ue

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $MIN_N     => 1;
const my $MAX_N     => 5;
const my $USAGE     => "USAGE: perl $0 <Int:N>   where $MIN_N <= N <= $MAX_N\n";
const my %FOLLOWERS =>
         (
             a => [ qw| e i     | ],
             e => [ qw| i       | ],
             i => [ qw| a e o u | ],
             o => [ qw| a u     | ],
             u => [ qw| o e     | ],
         );

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
    print "Challenge 053, Task #2: Vowel Strings (Perl)\n\n";

    my $args = scalar @ARGV;
       $args == 1                or die "ERROR: $args arguments found\n$USAGE";

    my $n = int $ARGV[0];
    $MIN_N <= $n && $n <= $MAX_N or die "ERROR: N = $n is out of range\n$USAGE";

    my @solution = qw( a e i o u );                     # The solution for N = 1

    for (2 .. $n)
    {
        my @temp;

        for my $string (@solution)
        {
            my $last = substr $string, -1;

            push @temp, $string . $_ for $FOLLOWERS{ $last }->@*;
        }

        @solution = @temp;
    }

    printf "For N = %d, the %d possible distinct vowel strings are:\n  %s\n",
            $n, scalar @solution, join "\n  ", @solution;
}

################################################################################
