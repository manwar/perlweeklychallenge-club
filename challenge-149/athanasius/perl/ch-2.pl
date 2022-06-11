#!perl

###############################################################################
=comment

Perl Weekly Challenge 149
=========================

TASK #2
-------
*Largest Square*

Submitted by: Roger Bell_West

Given a number base, derive the largest perfect square with no repeated digits
and return it as a string. (For base>10, use 'A'..'Z'.)

Example:

    f(2)="1"
    f(4)="3201"
    f(10)="9814072356"
    f(12)="B8750A649321"

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Since a valid solution must have no repeated digits, the largest possible
solution in base b has b digits, arranged from largest to smallest. From this
number, the largest possible perfect square is easily found. The search then
proceeds through successively smaller perfect squares until one is found which
satisfies the no-repeated-digits rule: this is the desired solution.

The "use bigint;" pragma is included to allow searches in bases of 16 or
higher. If the input base is restricted to the range 1 to 15, commenting out
this pragma will increase the speed of the search.

As base sizes increase, computation times quickly become prohibitively long.
The following table of solutions shows the rapid increase in the size of the
search space as bases increase in size:

     --------------------------------------------------------------------
         n                  Base n                    Decimal (from [1])
     --------------------------------------------------------------------
      f( 1) =                    1 =                                   1
      f( 2) =                    1 =                                   1
      f( 3) =                    1 =                                   1
      f( 4) =                 3201 =                                 225
      f( 5) =                 4301 =                                 576
      f( 6) =               452013 =                              38,025
      f( 7) =              6250341 =                             751,689
      f( 8) =             47302651 =                          10,323,369
      f( 9) =            823146570 =                         355,624,164
      f(10) =           9814072356 =                       9,814,072,356
      f(11) =          A8701245369 =                     279,740,499,025
      f(12) =         B8750A649321 =                   8,706,730,814,089
      f(13) =         CBA504216873 =                  23,132,511,879,129
      f(14) =       DC71B30685A924 =              11,027,486,960,232,964
      f(15) =      EDAC93B24658701 =             435,408,094,460,869,201
      f(16) =     FED5B39A42706C81 =          18,362,780,530,794,065,025
      f(17) =     GFED5A31C6B79802 =          48,470,866,291,337,805,316
      f(18) =    HGF80ADC53712EB64 =      39,207,739,576,969,100,808,801
      f(19) =  IHGFD3408C6E715A2B9 =   1,972,312,183,619,434,816,475,625
      f(20) = JIHG03DAC457BFE96281 = 104,566,626,183,621,314,286,288,961
     --------------------------------------------------------------------

It is noteworthy that even the OEIS [1] does not provide solutions for bases
greater than 20.

Output Display
--------------
As a search can take a considerable amount of time, a progressive output is
provided showing the current number being tested -- this "counts down" to the
solution. This display may be turned off by settng the constant VERBOSE to a
false value.

Reference
---------
[1] OEIS: A287298  a(n) is the largest square with distinct digits in base n.
    https://oeis.org/A287298

=cut
#==============================================================================

use strict;
use warnings;
use bigint;
use Const::Fast;
use Math::BaseCalc;
use Regexp::Common qw( number );

use constant VERBOSE => 1;

const my @CHARS    => (0 .. 9, 'A' .. 'Z');
const my $MAX_BASE => 36;
const my $BLANK    => ' ' x ($MAX_BASE + 10);
const my $USAGE    =>
"Usage:
  perl $0 <base>

    <base>    Number base: integer between 1 and 36\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 149, Task #2: Largest Square (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $base = parse_command_line();
    my $squ  = 1;

    if ($base > 1)
    {
        my $max = get_max_without_reps( $base );
        my $cnv = Math::BaseCalc->new(digits => [ @CHARS[ 0 .. $base - 1 ] ]);

        # Note: The more natural "for my $root (reverse 1 .. int sqrt $max)"
        #       consumes too much memory for large bases

        for (my $root = int sqrt $max; $root > 0; --$root)
        {
            $squ = $cnv->to_base($root * $root);

            print   qq[\r$BLANK\rTrying: "$squ"] if VERBOSE;

            if (has_no_reps( $squ ))
            {
                print "\r$BLANK\r"               if VERBOSE;
                last;
            }
        }
    }

    print qq[f($base) = "$squ"\n];
}

#------------------------------------------------------------------------------
sub has_no_reps
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  @digits = split //, $n;
    my  %digits;

    for my $d (@digits)
    {
        ++$digits{ $d };

        return 0 if $digits{ $d } > 1;
    }

    return 1;
}

#------------------------------------------------------------------------------
sub get_max_without_reps
#------------------------------------------------------------------------------
{
    my ($base) = @_;
    my  $max   = 0;

    for (my $i = 1; $i <= $base - 1; ++$i)
    {
        $max += $i * ($base ** $i);
    }

    return $max;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $base = $ARGV[ 0 ];

    $base =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$base" is not a valid integer] );

    $base >= 1    or error( qq[Base "$base" is too small] );

    $base <= $MAX_BASE
                  or error( qq[Base "$base" is too large] );

    return $base;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
