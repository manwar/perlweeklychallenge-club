use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 146
=========================

TASK #2
-------
*Curious Fraction Tree*

Submitted by: Mohammad S Anwar

Consider the following Curious Fraction Tree:

                                      1/1
                    ---------------------------------------
                   |                                       |
                   |                                       |
                  1/2                                     2/1
          -------------------                     -------------------
         |                   |                   |                   |
         |                   |                   |                   |
        1/3                 3/2                 2/3                 3/1
     ---------           ---------           ---------           ---------
    |         |         |         |         |         |         |         |
    |         |         |         |         |         |         |         |
   1/4       4/3       3/5       5/2       2/5       5/3       3/4       4/1

You are given a fraction, member of the tree created similar to the above
sample.

Write a script to find out the parent and grandparent of the given member.

Example 1:

    Input: $member = '3/5';
    Output: parent = '3/2' and grandparent = '1/2'

Example 2:

    Input: $member = '4/3';
    Output: parent = '1/3' and grandparent = '1/2'

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
The input numerator and denominator must be positive (non-zero) integers and
relative primes (i.e., coprimes).

Output
------
Standard output displays the parent and grandparent (if any) of the given
fraction, as per the Examples. In my view, however, a more interesting output
is a display of all the nodes which form a path from the root to the given
fraction. To see this additional output, set the constant $SHOW-PATH to True.

Algorithm
---------
As explained in [1], the children of each node a/b in the Curious Fraction Tree
are a/(a+b) (left) and (a+b)/b (right). Left children are always less than one,
and right children are always greater than one. Therefore, the parent of any
given fraction n/d may be found as follows:

    IF n = d = 1 THEN n/d is the root node, and has no parent
    ELSE
      IF n < d THEN n/d is a left  child, and its parent is n/(d - n)
      ELSE          n/d is a right child, and its parent is (n - d)/d
      ENDIF
    ENDIF

Of course, the grandparent of any fraction is simply the parent of its parent.

Reference
---------
[1] James Tanton, "Fractions are Hard! 5.3 A Curious Fraction Tree".
    https://gdaymath.com/lessons/fractions/5-3-a-curious-fraction-tree/

=end comment
#==============================================================================

subset Pos of Int where * > -1;

my Bool constant $SHOW-PATH = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 146, Task #2: Curious Fraction Tree (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Pos:D $num,                               #= Numerator:   positive integer
    Pos:D $den where { $num gcd $den == 1 }   #= Denominator: positive integer,
                                              #=      coprime to the numerator
)
#==============================================================================
{
    "Input:  member = '$num/$den'".put;

    my Pos ($pa, $pb) = 1, 1;

    'Output: '.print;

    if get-parent( $num, $den, $pa, $pb )
    {
        my Pos ($ga, $gb) = 1, 1;

        if get-parent( $pa, $pb, $ga, $gb )
        {
            "parent = '$pa/$pb' and grandparent = '$ga/$gb'".put;
        }
        else
        {
            "parent = '1/1' (root) and there is no grandparent".put;
        }
    }
    else
    {
        'root has no parent (or grandparent)'.put;
    }

    if $SHOW-PATH
    {
        my @path = get-all-ancestors( $num, $den );

        "\nPath from root:\n%s\n".printf: @path.join: ' --> ';
    }
}

#------------------------------------------------------------------------------
sub get-parent
(
    Pos:D $n,
    Pos:D $d,
    Pos:D $pa is rw,
    Pos:D $pb is rw
--> Bool:D
)
#------------------------------------------------------------------------------
{
    my Bool $has-parent = True;

    if $n == $d
    {
        $has-parent = False;
    }
    elsif $n < $d
    {
        $pa = $n;
        $pb = $d - $n;
    }
    else # $n > $d
    {
        $pa = $n - $d;
        $pb = $d;
    }

    return $has-parent;
}

#------------------------------------------------------------------------------
sub get-all-ancestors
(
    Pos:D $n is copy,
    Pos:D $d is copy
--> Seq:D[Str:D]
)
#------------------------------------------------------------------------------
{
    my Str  @path     = "$n/$d";
    my Pos ($pa, $pb) =  1, 1;

    while get-parent( $n, $d, $pa, $pb )
    {
        @path.push: "$pa/$pb";

        $n = $pa;
        $d = $pb;
    }

    return @path.reverse;
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
