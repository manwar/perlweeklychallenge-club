#!perl

###############################################################################
=comment

Perl Weekly Challenge 140, TASK #1: Add Binary

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

The "+" operator is overloaded via the _binary_add() subroutine, which adds two
binary numbers digit-by-digit, moving from the least significant digits to the
most significant digits. (Leading zeros are first added to the smaller of the
two binary numbers to simplify the implementation logic.)

=cut
#==============================================================================

use strict;
use warnings;

#==============================================================================
package BinUInt;
#==============================================================================

use overload '+'  => \&_binary_add;                           # Binary addition
use overload '""' => sub { $_[ 0 ]->{ value } };              # Stringification

#------------------------------------------------------------------------------
sub new                                                           # Constructor
#------------------------------------------------------------------------------
{
    my ($class, $str) = @_;

    $str =~ / ^ [01]+ $ /x
        or die qq["$str" is not a valid binary number\n];

    $str =~ s/ ^ 0+ (?=[01]) //x;                          # Trim leading zeros

    my $self = { value => $str };

    return bless $self, $class;
}

#------------------------------------------------------------------------------
sub _binary_add
#------------------------------------------------------------------------------
{
    my  ($self, $other, $swap) = @_;
    my   $lhs_len = length $self ->{ value };
    my   $rhs_len = length $other->{ value };
    my   $max_len = $lhs_len >= $rhs_len ? $lhs_len : $rhs_len;
    my   $carry   = 0;
    my   @lhs     = reverse split //, $self ->{ value };
    my   @rhs     = reverse split //, $other->{ value };
    my   @sum;
    push @lhs, '0' while scalar( @lhs ) < $max_len;
    push @rhs, '0' while scalar( @rhs ) < $max_len;

    for my $i (0 .. $max_len - 1)
    {
        my $subtotal = $lhs[ $i ] + $rhs[ $i ] + $carry;

        if    ($subtotal == 3)
        {
            $sum[ $i ] = 1;
            $carry     = 1;
        }
        elsif ($subtotal == 2)
        {
            $sum[ $i ] = 0;
            $carry     = 1;
        }
        else   # 1 or 0
        {
            $sum[ $i ] = $subtotal;
            $carry     = 0;
        }
    }

    push @sum, 1 if $carry;

    return BinUInt->new( join '', reverse @sum );
}

###############################################################################
1;
###############################################################################
