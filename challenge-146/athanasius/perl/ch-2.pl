#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
The input numerator and denominator must be positive (non-zero) integers and
relative primes (i.e., coprimes).

Output
------
Standard output displays the parent and grandparent (if any) of the given
fraction, as per the Examples.

In my view, however, a more interesting output is a display of all the nodes
which form a path from the root to the given fraction. To see this additional
output, set the constant $SHOW_PATH to a true value.

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( gcd );
use Regexp::Common    qw( number );

const my $SHOW_PATH => 1;
const my $USAGE     =>
"Usage:
  perl $0 <num> <den>

    <num>    Numerator:   positive integer
    <den>    Denominator: positive integer, coprime to the numerator\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 146, Task #2: Curious Fraction Tree (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($num, $den) = parse_command_line();

    print "Input:  member = '$num/$den'\n";

    my ($pa, $pb);

    print 'Output: ';

    if (get_parent( $num, $den, \$pa, \$pb ))
    {
        my ($ga, $gb);

        if (get_parent( $pa, $pb, \$ga, \$gb))
        {
            print "parent = '$pa/$pb' and grandparent = '$ga/$gb'\n";
        }
        else
        {
            print "parent = '1/1' (root) and there is no grandparent\n";
        }
    }
    else
    {
        print "root has no parent (or grandparent)\n";
    }

    if ($SHOW_PATH)
    {
        my $path = get_all_ancestors( $num, $den );

        printf "\nPath from root:\n%s\n", join ' --> ', @$path;
    }
}

#------------------------------------------------------------------------------
sub get_parent
#------------------------------------------------------------------------------
{
    my ($n, $d, $pa, $pb) = @_;
    my  $has_parent       = 1;

    if ($n == $d)
    {
        $has_parent = 0;
    }
    elsif ($n < $d)
    {
        $$pa = $n;
        $$pb = $d - $n;
    }
    else # $n > $d
    {
        $$pa = $n - $d;
        $$pb = $d;
    }

    return $has_parent;
}

#------------------------------------------------------------------------------
sub get_all_ancestors
#------------------------------------------------------------------------------
{
    my ($n,  $d ) = @_;
    my  @path     = "$n/$d";
    my ($pa, $pb);

    while (get_parent( $n, $d, \$pa, \$pb ))
    {
        push @path, "$pa/$pb";

        $n = $pa;
        $d = $pb;
    }

    @path = reverse @path;

    return \@path;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command line arguments, found $args" );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
                  or error( qq["$_" is not a valid integer] );

        $_ > 0    or error( "$_ is not positive" );
    }

    my ($num, $den) = @ARGV;

    gcd( $num, $den ) == 1
                  or error( "The numerator and denominator are not coprimes" );

    return ($num, $den);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
