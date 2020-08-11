use v6;

################################################################################
=begin comment

Perl Weekly Challenge 047
=========================

Task #2
-------
*Gapful Number*

Write a script to print first 20 Gapful Numbers greater than or equal to 100.
Please check out the [ https://oeis.org/A108343 |page] for more information
about Gapful Numbers.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

our UInt constant MINIMUM = 100;
our UInt constant TARGET  =  20;

BEGIN ''.say;

#===============================================================================
sub MAIN()
#===============================================================================
{
    my UInt $num   = MINIMUM;
    my UInt $count = 0;
    my UInt @gapfuls;

    while $count < TARGET
    {
        my UInt $div = ($num.split('', :skip-empty))[0] * 10 + $num % 10;

        if $num++ % $div == 0
        {
            @gapfuls.push: $num - 1;
            ++$count;
        }
    }

    "The first %d Gapful Numbers greater than or equal to %d are:\n%s\n".printf:
        TARGET, MINIMUM, @gapfuls.join(', ');
}

################################################################################
