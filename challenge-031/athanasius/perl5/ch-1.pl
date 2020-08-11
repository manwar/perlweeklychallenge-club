#!perl

################################################################################
=comment

Perl Weekly Challenge 031
=========================

Task #1
-------
Create a function to check *divide by zero error* without checking if the denom-
inator is zero.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;

const my $DEFAULT_DIVIDEND => 1;
const my $DEFAULT_DIVISOR  => 0;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $dividend = $ARGV[0] // $DEFAULT_DIVIDEND;
    my $divisor  = $ARGV[1] // $DEFAULT_DIVISOR;
    my $quotient = 'DIVIDE BY ZERO ERROR';

    eval
    {
        $quotient = $dividend / $divisor;
    };

    die $@ if $@ && $@ !~ /^Illegal division by zero/;

    print "$dividend / $divisor = $quotient\n\nNormal exit\n";
}

################################################################################
