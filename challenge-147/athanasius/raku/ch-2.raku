use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 147
=========================

TASK #2
-------
*Pentagon Numbers*

Submitted by: Mohammad S Anwar

Write a script to find the first pair of Pentagon Numbers whose sum and differ-
ence are also a Pentagon Number.

    Pentagon numbers can be defined as P(n) = n(3n - 1)/2.

Example

 The first 10 Pentagon Numbers are:
 1, 5, 12, 22, 35, 51, 70, 92, 117 and 145.

 P(4) + P(7) = 22 + 70 = 92 = P(8)
 but
 P(4) - P(7) = |22 - 70| = 48 is not a Pentagon Number.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Discussion
----------
Consider a pair J of Pentagon Numbers: J = (P(x), P(y)). If x = y, the differ-
ence P(x) - P(y) = 0, which is not a Pentagon Number. So we require x ≠ y. For
convenience, we specify x < y. Now consider a second pair K = (P(z), P(w))
where z < w. What is required to determine whether J < K?

If x < z AND y < w, it is clear that J < K. But if x < z and y > w, J is
neither greater than nor less than K. In fact, pairs of Pentagon Numbers form a
partially ordered set with a product ordering [1]. Therefore, the term "first
pair" is not well-defined.

For the purposes of this Task I assume that Pentagon Number pairs are ordered,
firstly, by the second (i.e., the larger) of the two Pentagon Numbers, and,
secondly, by the first (smaller) Pentagon Number. This assumption simplifies
the search algorithm since the upper search bound is always known up front.

The minimum value required for $MAX-PENT was found by trial and error.

Reference
---------
[1] https://en.wikipedia.org/wiki/Product_order

=end comment
#==============================================================================

my UInt constant $MAX-PENT = 2_400;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 147, Task #2: Pentagon Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    ("The first pair of Pentagon Numbers whose\n" ~
     "sum and difference are also Pentagon Numbers:\n").put;

    my UInt %pent-h = populate-pentagonals();
    my UInt @pent-a = %pent-h.keys.map( { .Int } ).sort;

    # Type-checking has been removed from the code below to speed up execution

    L-OUTER1:
    for 1 .. @pent-a.end -> $i
    {
        my $pi = @pent-a[  $i ];
        my $ni = %pent-h{ $pi };

        for 0 .. $i - 1 -> $j
        {
            my $pj  = @pent-a[  $j ];
            my $nj  = %pent-h{ $pj };
            my $sum = $pi + $pj;

            if %pent-h{ $sum }:exists
            {
                my $diff = abs( $pi - $pj );

                if %pent-h{ $diff }:exists
                {
                    ("P(%d) + P(%d) =  %d + %d  = %d = P(%d)\n" ~
                     "P(%d) - P(%d) = |%d - %d| = %d = P(%d)\n").printf:
                      $nj, $ni, $pj, $pi, $sum,  %pent-h{ $sum  },
                      $nj, $ni, $pj, $pi, $diff, %pent-h{ $diff };

                    last L-OUTER1;
                }
            }
        }
    }
}

#------------------------------------------------------------------------------
sub populate-pentagonals( --> Hash[UInt] )
#------------------------------------------------------------------------------
{
    my UInt %pent-hash;

    for 1 .. $MAX-PENT -> UInt $n
    {
        my UInt $p = ($n * (3 * $n - 1) / 2).Int;

        %pent-hash{ $p } = $n;
    }

    return %pent-hash;
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
