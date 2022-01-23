#!perl

###############################################################################
=comment

Perl Weekly Challenge 148
=========================

TASK #1
-------
*Eban Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate all Eban Numbers <= 100.

    An Eban number is a number that has no letter 'e' in it when the number is
    spelled in English (American or British).

Example

 2, 4, 6, 30, 32 are the first 5 Eban numbers.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
Eban numbers are a subset of the natural numbers.

Solution
--------
My first solution used CPAN's Math::BigInt::Named module (isn't CPAN wonder-
ful?), but in the end I went with a home-grown approach by listing the 28 names
required to spell the integers 1 to 100 in English.

Output
------
The output defaults to a list of Eban numbers, as shown in the Example. For a
more detailed output showing the English names of the Eban numbers, set the
constant $VERBOSE to a true value.

References
----------
https://oeis.org/A006933
https://en.wikipedia.org/wiki/Ban_number

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $MAX_EBAN     =>     100;
const my @SINGLE_NAMES => qw( '' one two three four five six seven eight nine
                              ten eleven twelve thirteen fourteen fifteen
                              sixteen seventeen eighteen nineteen );
const my @PREFIX_NAMES => qw( '' '' twenty thirty forty fifty sixty seventy
                              eighty ninety );
const my $ONE_HUNDRED  =>     'one hundred';
const my $USAGE        =>     "Usage:\n  perl $0\n";
const my $VERBOSE      =>     0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 148, Task #1: Eban Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";
    my @eban_nums;

    for my $n (1 .. 19)
    {
        push @eban_nums, $n unless $SINGLE_NAMES[ $n ] =~ /e/;
    }

    for my $p (2 .. 9)
    {
        next if $PREFIX_NAMES[ $p ] =~ /e/;

        for my $n (0 .. 9)
        {
            push @eban_nums, $p * 10 + $n unless $SINGLE_NAMES[ $n ] =~ /e/;
        }
    }

    push @eban_nums, 100 unless $ONE_HUNDRED =~ /e/;

    printf "There are %d Eban numbers <= %d:\n", scalar @eban_nums, $MAX_EBAN;

    if ($VERBOSE)
    {
        printf " %3d. %s\n", $_, get_name( $_ ) for @eban_nums;
    }
    else
    {
        printf "%s\n", join ', ', @eban_nums;
    }
}

#------------------------------------------------------------------------------
sub get_name
#------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  $name;

    if ($n < 20)
    {
        $name  = $SINGLE_NAMES[ $n ];
    }
    elsif ($n < 100)
    {
        $name  = $PREFIX_NAMES[ $n / 10 ];
        $name .= '-' .
                 $SINGLE_NAMES[ $n % 10 ] if $n % 10 > 0;
    }
    else
    {
        $name  = $ONE_HUNDRED;
    }

    return $name;
}

###############################################################################
