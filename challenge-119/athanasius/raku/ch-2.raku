use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 119
=========================

TASK #2
-------
*Sequence without 1-on-1*

Submitted by: Cheok-Yin Fung

Write a script to generate sequence starting at 1. Consider the increasing
sequence of integers which contain only 1’s, 2’s and 3’s, and do not have any
doublets of 1’s like below. Please accept a positive integer $N and print the
$Nth term in the generated sequence.

    1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, …

Example

 Input: $N = 5
 Output: 13

 Input: $N = 10
 Output: 32

 Input: $N = 60
 Output: 2223

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
1. Generate the series *with* doublets of '1' digits by:
   (a) Producing each successive term by incrementing the previous term by 1.
   (b) Converting any '4' digit that results to a 1 with a left-carry. This
       conversion continues from least- to most-significant digit until all of
       the '4' digits have been eliminated.
2. Filter out any term that contains adjacent 1 digits.
3. Continue until the number of terms generated equals $N. The final term to be
   generated is the solution.

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 119, Task #2: Sequence without 1-on-1 (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N where { $N > 0 }                            #= A positive integer
)
#==============================================================================
{
    my UInt $n = $N + 0;             # Normalize: e.g., 010 --> 10, 0x10 --> 16

    "Input:  \$N = $n".put;

    my UInt $term = generate-series( $N );

    "Output: $term".put;
}

#------------------------------------------------------------------------------
sub generate-series( UInt:D $N where { $N > 0 } --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt $term  = 1;
    my UInt $terms = 1;

    while $terms < $N             # Continue until $N terms have been generated
    {
        if ++$term ~~ /4/         # Handle overflow: 4 -> (+1)1
        {
            my UInt @digits = $term.split( '', :skip-empty ).map: { .Int };

            for (1 .. @digits.end).reverse -> UInt $i
            {
                if @digits[ $i ] == 4
                {
                    @digits[ $i     ] = 1;
                  ++@digits[ $i - 1 ];
                }
            }

            if  @digits[ 0 ] ==  4
            {
                @digits[ 0 ]  =  1;
                @digits.unshift: 1;
            }

            $term = @digits.join.Int;
        }

        ++$terms unless $term ~~ /11/;       # Filter out terms containing '11'
    }

    return $term;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
