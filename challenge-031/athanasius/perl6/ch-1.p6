use v6;

################################################################################
=begin comment

Perl Weekly Challenge 031
=========================

Task #1
-------
Create a function to check *divide by zero error* without checking if the denom-
inator is zero.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my Real constant $DEFAULT-DIVIDEND = 1;
my Real constant $DEFAULT-DIVISOR  = 0;

BEGIN say '';

#===============================================================================
sub MAIN
(
    Real:D $dividend = $DEFAULT-DIVIDEND,
    Real:D $divisor  = $DEFAULT-DIVISOR,
)
#===============================================================================
{
    try
    {
        my Real $quotient = $dividend / $divisor;

        "$dividend / $divisor = $quotient".say;
    }

    if $!
    {
        if $! ~~ rx/ ^ Attempt \s to \s divide .+ by \s zero /
        {
            "$dividend / $divisor = DIVIDE BY ZERO ERROR".say;
        }
        else
        {
            $!.throw;
        }
    }

    "\nNormal exit".say;
}

################################################################################
