use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 060
=========================

Task #1
-------
*Excel Column*

*Reviewed by: Ryan Thompson*

Write a script that accepts a number and returns the *Excel Column Name* it
represents and vice-versa.

Excel columns start at *A* and increase lexicographically using the 26 letters
of the English alphabet, *A*..*Z*. After *Z*, the columns pick up an extra
"digit", going from *AA*, *AB*, etc., which could (in theory) continue to an
arbitrary number of digits. In practice, Excel sheets are limited to 16,384
columns.

*Example*

Input Number: 28 Output: AB

Input Column Name: AD Output: 30

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Bool constant WARN-ON-RANGE = True;
my UInt constant MAX-COLUMN    = 16_384;         # = XFD: 24*26² + 6*26¹ + 4*26⁰

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
multi sub MAIN
(
    UInt:D $number where $number > 0     #= Excel column number: an integer >= 1
)
#===============================================================================
{
    "Challenge 060, Task #1: Excel Column (Raku)\n".put;

    "WARNING: Column $number is out of range".note
        if WARN-ON-RANGE && $number > MAX-COLUMN;

    my Str $name = number-to-name($number);

    "The Excel column number $number is named \"$name\"".put;
}

#-------------------------------------------------------------------------------
sub number-to-name( UInt:D $num is copy --> Str:D )
#-------------------------------------------------------------------------------
{
    my Str  $name = '';
    my UInt $exp  =  2;
    my UInt $max  = 26;                                 # Cf. OEIS A218729:
            $max += 26 ** $exp++ while $max < $num;     # 1, 27, 703, 18279, ...

    for reverse 0 .. $exp - 2 -> UInt $power
    {
        my UInt $div   = 26 ** $power;
        my UInt $quo   = ($num / $div).truncate;
                $quo   = 26 if $quo > 26;
                $name ~= ('A' .. 'Z')[$quo - 1];
                $num  -= $quo * $div;

        last if $num == 0;
    }

    return $name;
}

#===============================================================================
multi sub MAIN
(
    Str:D $str                    #= Excel column name: one or more letters only
)
#===============================================================================
{
    "Challenge 060, Task #1: Excel Column (Raku)\n".put;

    my Str $name = $str.uc;

    $name ~~ rx/ ^ <[ A .. Z ]>+ $ /
        or die "ERROR: Argument \"$str\" is not a valid column name\n$*USAGE";

    my UInt $number = name-to-number($name);

    "WARNING: Column \"$name\" is out of range".note
        if WARN-ON-RANGE && $number > MAX-COLUMN;

    "The Excel column named \"$name\" is number $number".put;
}

#-------------------------------------------------------------------------------
sub name-to-number( Str:D $name --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $number     = 0;
    my UInt $multiplier = 1;
    my Str  @chars      = $name.split: '', :skip-empty;

    while @chars
    {
        my Str $char = @chars.pop;
        $number     += $multiplier * ($char.ord - 'A'.ord + 1);
        $multiplier *= 26;
    }

    return $number;
}

###############################################################################
