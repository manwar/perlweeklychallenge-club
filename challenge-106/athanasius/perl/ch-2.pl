#!perl

###############################################################################
=comment

Perl Weekly Challenge 106
=========================

*Decimal String*

Submitted by: Mohammad S Anwar

You are given numerator and denominator i.e. $N and $D.

Write a script to convert the fraction into decimal string. If the fractional
part is recurring then put it in parenthesis.

Example

 Input: $N = 1, $D = 3
 Output: "0.(3)"

 Input: $N = 1, $D = 2
 Output: "0.5"

 Input: $N = 5, $D = 66
 Output: "0.0(75)"

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Neither Perl itself nor the core Math::BigRat module have an equivalent to the
Raku base-repeating() method. Nor, to my surprise, am I able to find a CPAN
module which provides this functionality. So I ported to Perl the Raku source
code in rakudo-2021.03/src/core.c/Rational.pm6.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::MoreUtils qw( first_index );
use Math::BigRat;
use POSIX           qw( floor );
use Regexp::Common  qw( number );

const my $BASE  => 10;
const my $USAGE =>
"Usage:
  perl $0 <N> <D>

    <N>    Numerator (an integer)
    <D>    Denominator (a non-zero integer)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 106, Task #2: Decimal String (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($N, $D) = parse_command_line();

    print "Input:  \$N = $N, \$D = $D\n";

    my ($non_rep, $rep) = base_repeating( $N, $D, $BASE );

    printf qq[Output: "%s%s"\n], $non_rep, $rep ? "($rep)" : '';
}

#------------------------------------------------------------------------------
# Adapted from rakudo-2021.03/src/core.c/Rational.pm6
#
sub base_repeating
#------------------------------------------------------------------------------
{
    my ($N, $D, $base) = @_;

    return (0, '') if $N == 0;

    # Reduce to normal (i.e., shortest) form

    my $rat = Math::BigRat->new( "$N / $D" );  # Implicitly calls $rat->bnorm()
    my $num = abs $rat->numerator;
    my $den = abs $rat->denominator;

    return ('-' x ($rat < 0) . $num, '') if $den == 1;

    my  @quotients = floor( $num / $den );
    my (@remainders, %remainders);

    while (1)
    {
        push @remainders, $num %= $den;
        last if $remainders{ $num }++ || $num == 0;
        $num *= $base;
        push @quotients, floor( $num / $den );
    }

    my ($rep, @cycle) = ('', ());

    if ($num)
    {
        @cycle = splice @quotients, 1 + first_index { $_ == $num } @remainders;
        $rep   = join '', @cycle;
    }

    splice @quotients, 1, 0, '.';

    my $non_rep = '-' x ($rat < 0) . join '', @quotients;

    return ($non_rep, $rep);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $c = scalar @ARGV;
       $c == 2      or  error( "Expected 2 command line arguments, found $c" );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
                    or  error( qq["$_" is not an integer] );
    }

    $ARGV[ 1 ] == 0 and error( 'The denominator cannot be zero' );

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
