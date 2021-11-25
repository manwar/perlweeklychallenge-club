use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 140, TASK #1: Add Binary

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

The "+" operator is overloaded for BinUInt objects. It adds two binary numbers
digit-by-digit, moving from the least significant digits to the most signifi-
cant digits. (Leading zeros are first added to the smaller of the two binary
numbers to simplify the implementation logic.)

=end comment
#==============================================================================

class X::BinUInt::Invalid { ... }                         # Forward declaration

#==============================================================================
class BinUInt
#==============================================================================
{
    has Str $.value;

    #--------------------------------------------------------------------------
    submethod BUILD( Str:D :$!value )
    #--------------------------------------------------------------------------
    {
        $!value ~~ / ^ <[01]>+ $ /
            or X::BinUInt::Invalid.new( value => $!value ).throw;

        $!value ~~ s/ ^ 0+ <?[01]> //;                     # Trim leading zeros
    }
}

#==============================================================================
multi sub infix:<+>( BinUInt:D $a, BinUInt:D $b --> BinUInt:D ) is export
#==============================================================================
{
    my UInt $lhs-len = $a.value.chars;
    my UInt $rhs-len = $b.value.chars;
    my UInt $max-len = $lhs-len >= $rhs-len ?? $lhs-len !! $rhs-len;
    my UInt $carry   = 0;
    my Str  @lhs     = $a.value.split( '', :skip-empty ).reverse;
    my Str  @rhs     = $b.value.split( '', :skip-empty ).reverse;
    my UInt @sum;

    @lhs.push: '0' while @lhs.elems < $max-len;
    @rhs.push: '0' while @rhs.elems < $max-len;

    for 0 .. $max-len - 1 -> UInt $i
    {
        my UInt $subtotal = @lhs[ $i ] + @rhs[ $i ] + $carry;

        if    $subtotal == 3
        {
            @sum[ $i ] = 1;
            $carry     = 1;
        }
        elsif $subtotal == 2
        {
            @sum[ $i ] = 0;
            $carry     = 1;
        }
        else  # 1 or 0
        {
            @sum[ $i ] = $subtotal;
            $carry     = 0;
        }
    }

    @sum.push: 1 if $carry;

    return BinUInt.new: value => @sum.reverse.join;
}

#==============================================================================
class X::BinUInt::Invalid is Exception
#==============================================================================
{
    has Str $!value;

    #--------------------------------------------------------------------------
    submethod BUILD( Str:D :$!value )
    #--------------------------------------------------------------------------
    {
    }
 
    #--------------------------------------------------------------------------
    method message( --> Str:D )
    #--------------------------------------------------------------------------
    {
        return qq["$!value" is not a valid binary number];
    }
}

##############################################################################
