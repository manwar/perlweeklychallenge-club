#!perl

################################################################################
=comment

Perl Weekly Challenge 066
=========================

Task #2
-------
*Power Integers*

*Submitted by:* Mohammad S Anwar

You are given an integer $N.

Write a script to check if the given number can be expressed as *m^n* where m
and n are positive integers. Otherwise print 0.

Please make sure m > 1 and n > 1.

*BONUS: If there are more than one ways to express the given number then print
all possible solutions.*

*Example 1:*

For given $N = 9, it should print 3² or 3^2.

*Example 2:*

For given $N = 45, it should print 0.

*Example 3:*

For given $N = 64, it should print all or one of 8^2 or 2^6 or 4^3.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use Modern::Perl   qw( 2018 );
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE  => <<~EOS;
          Usage:
            perl $0 <N> -- an integer
          EOS

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
    print "Challenge 066, Task #2: Power Integers (Perl)\n\n";

    die $USAGE unless @ARGV == 1 && $ARGV[0] =~ / ^ $RE{num}{int} $ /x;

    my $N    = $ARGV[0];
    my $done = 0;

    if ($N > 1)
    {
        my $powers = find_powers($N);

        if (scalar @$powers)
        {
            print join('  ', @$powers), "\n";
            $done = 1;
        }
    }

    print "0\n" unless $done;
}

#-------------------------------------------------------------------------------
sub find_powers
#-------------------------------------------------------------------------------
{
    my ($N) = @_;
    my  @powers;

    # The minimum exponent n is 2, since n > 1 (given)
    # The maximum exponent n is that for which the base m is minimum (also 2),
    #     so  2^n = N  =>  n = log⸤2⸥(N)

    my $max_n = int( log($N) / log(2) );

    for my $n (2 .. $max_n)                         # exponent
    {
        my $m = int( ($N ** (1 / $n)) + 0.5 );      # base
        my $p = int( ($m ** $n)       + 0.5 );      # power

        push @powers, "$m^$n" if $p == $N;
    }

    return \@powers;
}

################################################################################
