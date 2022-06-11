use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 149
=========================

TASK #2
-------
*Largest Square*

Submitted by: Roger Bell_West

Given a number base, derive the largest perfect square with no repeated digits
and return it as a string. (For base>10, use ‘A’..‘Z’.)

Example:

    f(2)="1"
    f(4)="3201"
    f(10)="9814072356"
    f(12)="B8750A649321"

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
Since a valid solution must have no repeated digits, the largest possible
solution in base b has b digits, arranged from largest to smallest. From this
number, the largest possible perfect square is easily found. The search then
proceeds through successively smaller perfect squares until one is found which
satisfies the no-repeated-digits rule: this is the desired solution.

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
solution. This display may be turned off by settng the constant $VERBOSE to
False.

Reference
---------
[1] OEIS: A287298  a(n) is the largest square with distinct digits in base n.
    https://oeis.org/A287298

=end comment
#==============================================================================

my UInt constant $MAX-BASE = 36;
my Str  constant $BLANK    = ' ' x ($MAX-BASE + 10);
my Bool constant $VERBOSE  = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 149, Task #2: Largest Square (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| Number base: integer between 1 and 36

    UInt:D $base where 0 < * <= $MAX-BASE
)
#==============================================================================
{
    my Str  $squ = '1';
    my UInt $max = [+] (1 .. $base - 1).map: { $_ * ($base ** $_) };

    if $base > 1
    {
        for $max.sqrt.floor ... 1 -> UInt $r
        {
            $squ = $r².base( $base );

            qq[\r$BLANK\rTrying: "$squ"].print if $VERBOSE;

            if has-no-reps( $squ )
            {
                "\r$BLANK\r".print             if $VERBOSE;
                last;
            }
        }
    }

    qq[f(%d) = "%s"\n].printf: $base, $squ;
}

#------------------------------------------------------------------------------
sub has-no-reps( Str:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt %digits;

    for $n.split: '', :skip-empty
    {
        return False if ++%digits{ $_ } > 1;
    }

    return True;
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
