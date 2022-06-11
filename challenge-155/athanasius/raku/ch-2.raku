use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 155
=========================

TASK #2
-------
*Pisano Period*

Submitted by: Mohammad S Anwar

Write a script to find the period of the 3rd Pisano Period.

    In number theory, the nth Pisano period, written as π(n), is the period
    with which the sequence of Fibonacci numbers taken modulo n repeats.

The Fibonacci numbers are the numbers in the integer sequence:

 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584,
 4181, 6765, ...

For any integer n, the sequence of Fibonacci numbers F(i) taken modulo n is
periodic. The Pisano period, denoted π(n), is the value of the period of this
sequence. For example, the sequence of Fibonacci numbers modulo 3 begins:

 0, 1, 1, 2, 0, 2, 2, 1,
 0, 1, 1, 2, 0, 2, 2, 1,
 0, 1, 1, 2, 0, 2, 2, 1, ...

This sequence has period 8, so π(3) = 8.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Although the Task specifies n = 3, I have extended the solution to accept any
target integer value of n greater than 0. (If no argument is supplied on the
command line, the target n defaults to 3.)

If the constant $VERBOSE is set to True (the default), the required period is
followed by the contents of each cycle. Following the example of the "Tables"
section in [3], cycles are displayed with spaces before zeros and with numbers
greater than 9 represented by alphabetic characters. For example, for n = 13:

    The 13th Pisano Period is 28, with cycle: 0112358 0883B1C 0CCBA85 055A2C1

Known Facts
-----------
(1) The Pisano period π(n) is always even for values of n > 2 [3]
(2) The maximum value of π(n) is 6n [1, 3]

Algorithm
---------
1.  Generate the first 12n Fibonacci numbers (this is the minimum needed to
    ensure that the largest possible period, 6n, will be tested for at least 1
    whole cycle in Step 3)
2.  Derive @mods, the first 12n Fibonacci numbers modulo n
3.  Search for the smallest period p for which each element in its first cycle
    in @mods matches that element's corresponding elements in all subsequent
    cycles in @mods. For example, if n = 3, then @mods =
    0 1 1 2 0 2 2 1 0 1 1 2 0 2 2 1 0 1 1 2 0 2 2 1 0 1 1 2 0 2 2 1 0 1 1 2
    and the search proceeds as follows:
    for p = 1, $mods[0] != $mods[ 1];
    for p = 2, $mods[0] != $mods[ 2];
    for p = 3, $mods[0] != $mods[ 3];
    for p = 4, $mods[0] == $mods[ 4] but $mods[1] != $mods[5];
    for p = 5, $mods[0] != $mods[ 5];
    for p = 6, $mods[0] != $mods[ 6];
    for p = 7, $mods[0] != $mods[ 7];
    for p = 8, $mods[0] == $mods[ 8] == $mods[16] == $mods[24] == $mods[32],
               $mods[1] == $mods[ 9] == $mods[17] == $mods[25] == $mods[33],
               $mods[2] == $mods[10] == $mods[18] == $mods[26] == $mods[34],
               and so on to
               $mods[7] == $mods[15] == $mods[23] == $mods[31]
    Therefore, the search finds π(n) = 8
4.  Output the period and, optionally, its corresponding cycle

Note on Generating Fibonacci Numbers
------------------------------------
Raku's sequence operator ("…" or "...") makes it possible to generate
Fibonacci numbers very succinctly [4]:

    my UInt @fibs = (0, 1, * + * … *)[ ^(2 * $max-p) ];

("^" is the upto operator which "generates a range from 0 up to (but excluding)
the argument." [5])

References
----------
[1]  K. S. Brown (2017), "Periods of Fibonacci Sequences Mod m",
     https://oeis.org/A001175/a001175_1.pdf
[2] "A001175  Pisano periods (or Pisano numbers): period of Fibonacci numbers
     mod n.", The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A001175
[3] "Pisano period", Wikipedia, https://en.wikipedia.org/wiki/Pisano_period
[4] "Infix ..." in "Operators", Raku Documentation,
     https://docs.raku.org/language/operators#index-entry-..._operators
[5] "(Operators) prefix ^" in "routine ^", Raku Documentation,
     https://docs.raku.org/routine/$CIRCUMFLEX_ACCENT

=end comment
#==============================================================================

my UInt constant $TARGET  = 3;
my Bool constant $VERBOSE = True;
my      constant @DIGITS  = Array[Str].new: |('0' .. '9'), |('A' .. 'Z'),
                                                           |('a' .. 'z');
my UInt constant $MAX-LEN = 30;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 155, Task #2: Pisano Period (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $n where * > 0 = $TARGET  #= Integer > 0: The required Pisano Period
)
#==============================================================================
{
    my Bool $verbose =  $VERBOSE && $n <= +@DIGITS;
    my UInt $max-p   =  6 * $n;
    my UInt @fibs    = (0, 1, * + * … *)[ ^(2 * $max-p) ];
    my UInt @mods    =  @fibs.map: { $_ % $n };
    my UInt $period  =  0;
    my UInt @periods =  $n <= 2 ?? |(1 .. $max-p) !! 2, * + 2 … $max-p;

    PERIOD:
    for @periods -> UInt $p
    {
        for ^$max-p -> UInt $i
        {
            my UInt $f = @mods[ $i ];

            for $i + $p, * + $p …^ * >= +@mods -> UInt $j
            {
                next PERIOD unless @mods[ $j ] == $f;
            }
        }

        $period = $p;
        last PERIOD;
    }

    $period > 0 or die "No period found for n = $n";

    "The %d%s Pisano Period is %d%s\n".printf:
        $n, ordinal( $n ), $period,
        $verbose ?? ", with cycle: { get-cycle( @mods, $period ) }" !! '';
}

#------------------------------------------------------------------------------
sub get-cycle( Array:D[UInt:D] $mods, UInt:D $period --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $cycle;
           $cycle ~= @DIGITS[ $_ ] for $mods[ ^$period ];

    if $period <= $MAX-LEN
    {
        $cycle ~~ s :g / (.) <?before 0> /$0 /;
    }
    else
    {
        $cycle ~~ s :g / (.) <?before 0> /$0\n/;
        $cycle =  "\n" ~ $cycle; 
    }

    return $cycle;
}

#------------------------------------------------------------------------------
sub ordinal( UInt:D $n where * > 0 --> Str:D )
#------------------------------------------------------------------------------
{
    my Str  $ord  = 'th';
    my UInt $tens = (($n / 10) % 10).floor;   # "Tens" digit (or 0 if $n < 10)

    if $tens != 1
    {
        my UInt $lsd = $n % 10;               # Least significant ("ones) digit

        $ord = $lsd == 1 ?? 'st' !!
               $lsd == 2 ?? 'nd' !!
               $lsd == 3 ?? 'rd' !! 'th';
    }

    return $ord;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
