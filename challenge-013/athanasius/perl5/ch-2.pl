#!perl

################################################################################
=comment

Perl Weekly Challenge 013
=========================

Challenge #2
------------

Write a script to demonstrate *Mutually Recursive* methods. Two methods are
mutually recursive if the first method calls the second and the second calls
first in turn. Using the mutually recursive methods, generate
[ https://en.wikipedia.org/wiki/Hofstadter_sequence#
Hofstadter_Female_and_Male_sequences |Hofstadter Female and Male sequences].

 F ( 0 ) = 1   ;   M ( 0 ) = 0
 F ( n ) = n − M ( F ( n − 1 ) ) , n > 0
 M ( n ) = n − F ( M ( n − 1 ) ) , n > 0.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use utf8;
use warnings;
use Const::Fast;
use Memoize;
use Regexp::Common;
use constant TIMER => 1;

const my $DEFAULT =>  21;
const my $USAGE   => "perl $0 [ <series_length> ]";

$| = 1;

MAIN:
{
    @ARGV <= 1
        or die "\n$USAGE\n";

    my $n = $ARGV[0] // $DEFAULT;

    $n =~ /^$RE{num}{int}$/ && $n > 0
        or die "\nInvalid series length '$n': must be an integer > 0\n";

    --$n;  # Convert series length to index of final term (series is zero-based)

    # Memoization produces an enormous speed-up for even moderately-sized n

    memoize('F');
    memoize('M');

    for my $func ('F', 'M')
    {
        printf "\n%s(%s%d): %s\n", $func, ($n == 0 ? '' : '0..'), $n,
                                   join( ', ', seq(\&{$func}, $n)->@* );
    }
}

sub seq     # Accumulate terms ( X(0) .. X(max) ), where X is either F or M
{
    my ($func, $max) = @_;     # max ∊ N ∪ {0}

    my   @series;
    push @series, $func->($_) for 0 .. $max;

    return \@series;
}

sub F       # Find term n in the "Female" series
{
    my ($n) = @_;           # n ∊ N ∪ {0}

    return $n == 0 ? 1                          # Base case
                   : $n - M( F($n - 1) );       # Mutual recursion
}

sub M       # Find term n in the "Male" series
{
    my ($n) = @_;           # n ∊ N ∪ {0}

    return $n == 0 ? 0                          # Base case
                   : $n - F( M($n - 1) );       # Mutual recursion
}

################################################################################
