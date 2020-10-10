use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 080
=========================

Task #2
-------
*Count Candies*

Submitted by: Mohammad S Anwar

You are given rankings of @N candidates.

Write a script to find out the total candies needed for all candidates. You are
asked to follow the rules below:

a) You must given at least one candy to each candidate.
b) Candidate with higher ranking get more candies than their immediate neigh-
   bors on either side.

Example 1:

 Input: @N = (1, 2, 2)

Explanation:

 Applying rule #a, each candidate will get one candy. So total candies needed
 so far 3. Now applying rule #b, the first candidate do not get any more candy
 as its rank is lower than it's neighbours. The second candidate gets one more
 candy as it's ranking is higher than it's neighbour. Finally the third candi-
 date do not get any extra candy as it's ranking is not higher than neighbour.
 Therefore total candies required is 4.

 Output: 4

Example 2:

 Input: @N = (1, 4, 3, 2)

Explanation:

 Applying rule #a, each candidate will get one candy. So total candies needed
 so far 4. Now applying rule #b, the first candidate do not get any more candy
 as its rank is lower than it's neighbours. The second candidate gets two more
 candies as it's ranking is higher than it's both neighbour. The third candi-
 date gets one more candy as it's ranking is higher than it's neighbour. Final-
 ly the fourth candidate do not get any extra candy as it's ranking is not
 higher than neighbour. Therefore total candies required is 7.

 Output: 7

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Bool constant $CHECK-RULE-B      = True;
my Bool constant $SHOW-DISTRIBUTION = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 080, Task #2: Count Candies (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    *@N               #= A list of candidate rankings (numeric)
)
##=============================================================================
{
    my Num  @rankings;
            @rankings.push: .Num for @N;

    my UInt @candies = 1 xx @rankings.elems;                   # Apply Rule (a)

    Nil while distribute-candies(@rankings, @candies);         # Apply Rule (b)

    if $CHECK-RULE-B
    {
        satisfies-b(@rankings, @candies) or
            die 'ERROR: The solution breaks Rule (b)';
    }

    "Input: @N = (%s)\n".printf: @rankings.join: ', ';
    "Candies:    (%s)\n".printf: @candies\.join: ', ' if $SHOW-DISTRIBUTION;

    "Total candies needed: %d\n".printf: @candies.sum;

    CATCH
    {
        when X::TypeCheck::Assignment
        {
            'Non-numeric input'.put;
            USAGE();
        }
    }
}

#------------------------------------------------------------------------------
sub distribute-candies
(
    Array:D[Num:D] $N,               #= Candidate rankings
    Array:D[Num:D] $C,               #= Candy distribution
--> Bool:D                           #= The candy distribution has been changed
)
#------------------------------------------------------------------------------
{
    my Bool $changed = False;

    for 0 .. $N.end - 1 -> UInt $i                # 1. Distribute left-to-right
    {
        my UInt $j = $i + 1;

        if $N[$i] > $N[$j] && $C[$i] <= $C[$j]
        {
            $C[$i]   = $C[$j] + 1;
            $changed = True;
        }
    }

    for (1 .. $N.end).reverse -> UInt $i          # 2. Distribute right-to-left
    {
        my UInt $j = $i - 1;

        if $N[$i] > $N[$j] && $C[$i] <= $C[$j]
        {
            $C[$i]   = $C[$j] + 1;
            $changed = True;
        }
    }

    return $changed;
}

#------------------------------------------------------------------------------
sub satisfies-b
(
    Array:D[Num:D] $N,             #= Candidate rankings
    Array:D[Num:D] $C,             #= Candy distribution
--> Bool:D                         #= The candy distribution satisfies Rule (b)
)
#------------------------------------------------------------------------------
{
    for 0 .. $N.end - 1 -> UInt $i            # 1. Check Rule (b) left-to-right
    {
        if  $N[$i] > $N[$i + 1]
        {
            $C[$i] > $C[$i + 1] or return False;
        }
    }

    for (1 .. $N.end).reverse -> UInt $i      # 2. Check Rule (b) right-to-left
    {
        if  $N[$i] > $N[$i - 1]
        {
            $C[$i] > $C[$i - 1] or return False;
        }
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

###############################################################################
