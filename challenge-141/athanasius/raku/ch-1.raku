use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 141
=========================

TASK #1
-------
*Number Divisors*

Submitted by: Mohammad S Anwar

Write a script to find lowest 10 positive integers having exactly 8 divisors.

Example

 24 is the first such number having exactly 8 divisors.
 1, 2, 3, 4, 6, 8, 12 and 24.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Configuration
-------------
- Set $VERBOSE to True to show the divisors of each integer in the solution
- $DIVISORS is configurable; e.g., $DIVISORS = 2 generates the prime numbers!

Algorithm
---------
1. Divisors come in pairs: if i is a divisor of n then j = n / i is also a
   divisor of n
2. If i = j then i = sqrt(n)

So, to find all the divisors of n by searching, it's only necessary to search
the range 1 to sqrt(n):

    divisors := empty
    FOR d in range 1 to ⌊sqrt(n)⌋
        IF d is a divisor of n THEN
            Add d to divisors
            d1 := n / d
            IF d < d1
                Add d1 to divisors
            ENDIF
        ENDIF
    ENDFOR
    sort divisors ascending

=end comment
#==============================================================================

my Bool constant $VERBOSE  = True;
my UInt constant $DIVISORS =  8;
my UInt constant $TARGET   = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 141, Task #1: Number Divisors (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    "The lowest %d positive integers having exactly %d divisors:\n".printf:
            $TARGET, $DIVISORS;

    loop (my (Bool $first, UInt $n, UInt $count) = (True, 1, 0);
          $count < $TARGET; ++$n)
    {
        my UInt @divisors = find-divisors( $n );

        if @divisors.elems == $DIVISORS
        {
            if $VERBOSE
            {
                "    %d (%s )\n".printf:
                    $n, @divisors.map( { '%2d'.sprintf: $_ } ).join: ', ';
            }
            else
            {
                '%s%d'.printf: $first ?? '    ' !! ', ', $n;
            }

            $first = False;
            ++$count;
        }
    }

    "\n".print unless $VERBOSE;
}

#------------------------------------------------------------------------------
sub find-divisors( UInt:D $n --> Seq:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @div;

    for 1 .. $n.sqrt.Int -> UInt $d
    {
        if $n % $d == 0
        {
            @div.push: $d;

            my UInt $d1 = $n div $d;          # Note: integer division

            @div.push: $d1 if $d < $d1;
        }
    }

    return @div.sort;
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
