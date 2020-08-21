use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 073
=========================

Task #2
-------
*Smallest Neighbour*

Submitted by: Mohammad S Anwar

You are given an array of integers @A.

Write a script to create an array that represents the smaller element to the
left of each corresponding index. If none found then use 0.

Example 1

Input: @A = (7, 8, 3, 12, 10)
Output: (0, 7, 0, 3, 3)

For index 0, the smallest number to the left of $A[0] i.e. 7 is none, so we put
0.
For index 1, the smallest number to the left of $A[1] as compare to 8, in (7) is
7 so we put 7.
For index 2, the smallest number to the left of $A[2] as compare to 3, in (7, 8)
is none, so we put 0.
For index 3, the smallest number to the left of $A[3] as compare to 12, in (7,
8, 3) is 3, so we put 3.
For index 4, the smallest number to the left of $A[4] as compare to 10, in (7,
8, 3, 12) is 3, so we put 3 again.

Example 2

Input: @A = (4, 6, 5)
Output: (0, 4, 4)

For index 0, the smallest number to the left of $A[0] is none, so we put 0.
For index 1, the smallest number to the left of $A[1] as compare to 6, in (4) is
4, so we put 4.
For index 2, the smallest number to the left of $A[2] as compare to 5, in (4, 6)
is 4, so we put 4 again.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 073, Task #2: Smallest Neighbour (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    *@A where { @A.elems >  0  &&            #= Sequence of one or more integers
                @A.all   ~~ Int:D }
)
#===============================================================================
{
    my Int @out = (0);          # The first element has no left-hand neighbours
                                #   and so is always 0
    my Int $min = @A[0];        # In the loop below, $min contains the smallest
                                #   of the elements with index 0 .. $i-1

    # For each element @A[$i] after the first: record the minimum of the ele-
    # ments with index 0..$i-1 IFF that minimum is less than @A[$i]; otherwise,
    # record 0

    for 1 .. @A.end -> UInt $i
    {
        my Int $current = @A[$i];

        @out.push: $min < $current ?? $min !! 0;

        $min = $current if $current < $min;     # Update $min for next iteration
    }

    print-arrays(@A, @out);
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

#-------------------------------------------------------------------------------
sub print-arrays(Array:D[Int:D] $input, Array:D[Int:D] $output)
#-------------------------------------------------------------------------------
{
    my UInt @widths;

    # Calculate the print width for each element to facilitate vertical align-
    # ment of corresponding elements in the input and output sequences 

    for 0 .. $input.end -> UInt $i
    {
        my $len_in  =  $input[$i].chars;
        my $len_out = $output[$i].chars;

        @widths.push: $len_in > $len_out ?? $len_in !! $len_out;
    }

    # Print the input and output sequences

    for ['Input: @A =', $input ],
        ['Output:',     $output] -> @args
    {
        my @array = @args[1].list;

        "%-11s (%s)\n".printf:
            @args[0],
           (0 .. @array.end).map( { '%*d'.sprintf: @widths[$_], @array[$_] } )
                            .join: ', ';
    }
}

################################################################################
