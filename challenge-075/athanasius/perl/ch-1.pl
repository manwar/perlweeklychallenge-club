#!perl

################################################################################
=comment

Perl Weekly Challenge 075
=========================

Task #1
-------
*Coins Sum*

Submitted by: Mohammad S Anwar

You are given a set of coins _@C_, assuming you have infinite amount of each
coin in the set.

Write a script to find how many ways you make sum _$S_ using the coins from the
set _@C_.

Example:

Input:
    @C = (1, 2, 4)
    $S = 6

Output: 6
There are 6 possible ways to make sum 6.
a) (1, 1, 1, 1, 1, 1)
b) (1, 1, 1, 1, 2)
c) (1, 1, 2, 2)
d) (1, 1, 4)
e) (2, 2, 2)
f) (2, 4)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

                                    # Exports:
use strict;
use warnings;
use Const::Fast;                    # const()
use Getopt::Long;                   # GetOptions()
use Memoize;                        # memoize()
use Regexp::Common qw( number );    # %RE{num}

const my $USAGE =>
"Usage:
  perl $0 [-S=<Natural>] [<C> ...]

    -S=<Natural>    Target coin sum
    [<C> ...]       Non-empty set of coin denominations (Naturals <= S)\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 075, Task #1: Coins Sum (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my ($S, @C) = parse_command_line();

    # Ensure that @C is a *set* by removing any duplicate coin values; also sort
    # the values

    my %C = map  { $_  => undef } @C;
       @C = sort { $a <=> $b    } keys %C;

    # For non-trivial cases, memoization vastly decreases computation time

    memoize('count_coin_combinations');

    # Reversing the coin array -- so that the coins are processed in decreasing
    # order, largest coins first, smallest coins last -- significantly reduces
    # the total number of recursive calls to count_coin_combinations()

    my $total = count_coin_combinations($S, reverse @C);

    printf "There %s %s possible way%s to make the sum %s from the coin%s %s\n",
            $total    == 1 ? 'is' : 'are',
            add_commas($total),
            $total    == 1 ? ''   : 's',
            add_commas($S),
            scalar @C == 1 ? ''   : 's',
            join ', ', @C;
}

#-------------------------------------------------------------------------------
sub count_coin_combinations                                 # Recursive function
#-------------------------------------------------------------------------------
{
    my ($target, $coin, @coins) = @_;
    my  $sum = 0;

    if (scalar @coins)              # There are more coins to process
    {
        for my $i (0 .. int($target / $coin))
        {
            my $new_target = $target - ($i * $coin);

            if ($new_target == 0)   # Base case 1: target already reached
            {
                ++$sum;
            }
            else                    # Recursive case
            {
                $sum += count_coin_combinations($new_target, @coins);
            }
        }
    }
    else                            # Base case 2: no more coins
    {
        $sum = 1 if $target % $coin == 0;
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $S;

    GetOptions('S=i' => \$S)    or die $USAGE;

    my @C = @ARGV;

    scalar @C > 0               or die $USAGE;
    is_natural($S)              or die $USAGE;
    is_natural($_) && $_ <= $S  or die $USAGE for @C;

    return ($S, @C);
}

#-------------------------------------------------------------------------------
sub is_natural
#-------------------------------------------------------------------------------
{
    my ($n) = @_;

    return defined($n) && $n =~ / \A $RE{num}{int} \z /x && $n > 0;
}

#-------------------------------------------------------------------------------
sub add_commas
#-------------------------------------------------------------------------------
{
    my ($number) = @_;

    # Regex from perlfaq5: "How can I output my numbers with commas added?"

    return $number =~ s/(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))/$1,/gr;
}

################################################################################
