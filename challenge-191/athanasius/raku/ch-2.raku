use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 191
=========================

TASK #2
-------
*Cute List*

Submitted by: Mohammad S Anwar

You are given an integer, 0 < $n <= 15.

Write a script to find the number of orderings of numbers that form a cute
list.

With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of
@list is cute if for every entry, indexed with a base of 1, either

  1) $list[$i] is evenly divisible by $i
  or
  2) $i is evenly divisible by $list[$i]

Example

  Input: $n = 2
  Output: 2

  Since $n = 2, the list can be made up of two integers only i.e. 1 and 2.
  Therefore we can have two list i.e. (1,2) and (2,1).

  @list = (1,2) is cute since $list[1] = 1 is divisible by 1 and $list[2] = 2
  is divisible by 2.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. Set $TIMER to True to display the total time taken.

Assumption
----------
There are 15 possible inputs, each with a pre-computable output. Therefore, the
most efficient "solution" to this Task would be a simple lookup table. However,
as that would be trivial, I assume that what is wanted is a script to *calcu-
late* solutions efficiently.

Algorithm
---------
The total number of permutations of integers 1 to n is n!, which renders a
brute force search impractical for values of n above around 11 (11! is almost
40 million). The following table shows the potential maximum search space (n!)
for n in the range 1 to 15; also shown is f(n), "the number of orderings of
numbers that form a cute list", i.e., the correct solution for each n:

        ---------------------------------
           n    f(n)                 n!
        ---------------------------------
           1       1                  1
           2       2                  2
           3       3                  6
           4       8                 24
           5      10                120
           6      36                720
           7      41              5,040
           8     132             40,320
           9     250            362,880
          10     700          3,628,800
          11     750         39,916,800
          12   4,010        479,001,600
          13   4,237      6,227,020,800
          14  10,680     87,178,291,200
          15  24,679  1,307,674,368,000
        ---------------------------------

It is therefore necessary to drastically reduce the search space. This is
accomplished by the following algorithm:

1. A count of "cute" list orderings is initialised to zero.
2. For each index (list position, 1 to n, in the ordering), a list is computed
   of the numbers (again, drawn from 1 to n) which can satisfy the "cuteness"
   conditions while appearing at that index; these are the "options" for that
   position.
3. The position with the fewest number of options is selected.
4. For each of those options p:
   4.1 p is removed from the lists of remaining options
   4.2 Steps 3 and 4 are repeated recursively with the reduced option set until
       either:
       - the options for a particular index reduce to zero, in which case this
         branch of the recursive search is truncated; or
       - all list positions are filled, in which case the recursive search ends
         and the count is incremented.
5. The count is output as the required solution.

Performance
-----------
On my machine (Intel Core2 Duo T5850 @ 2.1 GHz, running Windows 8.1 64-bit and
Rakudo v2022.07 [Raku v6.d]), the test suite requires at least 15 seconds to
complete: about 4 times slower than for its Perl equivalent.

Implementation Note
-------------------
Removal of (most) type constraints from the computation-intensive subroutines
count-recursive() and choose-next-key() produced a significant efficiency gain:
the time required to run the test suite decreased by about a third (43 seconds
down to 15 seconds).

=end comment
#==============================================================================

use Test;

my UInt constant $MAX-N       = 15;
my UInt constant $TEST-FIELDS =  3;
my Bool constant $TIMER       = True;

subset N-type of Int where 0 < * <= $MAX-N;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 191, Task #2: Cute List (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    UInt $n where * ~~ N-type:D              #= An integer in the range 1 to 15
)
#==============================================================================
{
    my Instant $t0 = now               if $TIMER;

    "Input:  \$n = $n".put;
    "Output: %d\n".printf: count-cute-lists( $n );

    "\n%s seconds\n".printf: now - $t0 if $TIMER;
}

#==============================================================================
multi sub MAIN()                                           # Run the test suite
#==============================================================================
{
    my Instant $t0 = now               if $TIMER;

    run-tests();

    "\n%s seconds\n".printf: now - $t0 if $TIMER;
}

#------------------------------------------------------------------------------
sub count-cute-lists( N-type:D $n --> UInt:D )
#------------------------------------------------------------------------------
{
    my %options;                                    # Both numbers-per-position
                                                    #  and positions-per-number
    for 1 .. $n -> N-type $i
    {
        for 1 .. $n -> N-type $j
        {
            %options{ $i }.push( $j ) if $i %% $j || $j %% $i;
        }
    }

    return count-recursive( %options );
}

#------------------------------------------------------------------------------
sub count-recursive( $options )
#------------------------------------------------------------------------------
{
    my UInt $count = 0;

    if (my @keys = $options.keys).elems == 1                        # Base case
    {
        ++$count;                               # This solution is now complete
    }
    else
    {
        my $key = choose-next-key( $options );        # Key with fewest options

        OP: for $options{ $key }.list -> $op
        {
            my %my-options = $options.deepmap( -> $c is copy {$c} );

            %my-options{ $key }:delete;                      # Simplifying step

            for %my-options.keys -> $k
            {
                # Remove each occurrence of $op from the remaining options

                my @ops;
                $_ == $op or @ops.push: $_ for %my-options{ $k }.list;

                next OP if @ops.elems == 0;              # Truncate this branch
                                                         # of the decision tree
                %my-options{ $k } = @ops;
            }

            $count += count-recursive( %my-options );          # Recursive case
        }
    }

    return $count;
}

#------------------------------------------------------------------------------
sub choose-next-key( $options )
#------------------------------------------------------------------------------
{
    # Choose the key with the MINIMUM number of options:
    # this produces a significant speed-up

    my %counts;

    for $options.keys
    {
        %counts{ $_ } = $options{ $_ }.elems;
    }

    my $min = %counts.values.min;
    my %rev = %counts.antipairs;

    return %rev{ $min };
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $n, $expected) =
            $line.split: / \, \s* /, $TEST-FIELDS, :skip-empty;

        is count-cute-lists( $n.Int ), $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        One,       1,     1
        Two,       2,     2
        Three,     3,     3
        Four,      4,     8
        Five,      5,    10
        Six,       6,    36
        Seven,     7,    41
        Eight,     8,   132
        Nine,      9,   250
        Ten,      10,   700
        Eleven,   11,   750
        Twelve,   12,  4010
        Thirteen, 13,  4237
        Fourteen, 14, 10680
        Fifteen,  15, 24679
        END
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
