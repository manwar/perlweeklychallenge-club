use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 059
=========================

Task #1
-------
*Linked List*

*Reviewed by Ryan Thompson*

You are given a linked list and a value _k_. Write a script to partition the
linked list such that all nodes less than _k_ come before nodes greater than or
equal to _k_. Make sure you preserve the original relative order of the nodes in
each of the two partitions.

For example:

Linked List: 1 → 4 → 3 → 2 → 5 → 2

_k_ = 3

Expected Output: 1 → 2 → 2 → 4 → 3 → 5.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

# Note: To make the Perl5 module LinkedList::Single work correctly in Raku, I
#       found I needed to add a stopper to signify the end of a linked list. I
#       chose a value of NaN; Raku has a method Complex::isNaN which I use to
#       test for end-of-list in the list-walking loops.

use LinkedList::Single:from<Perl5>;

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN()
#===============================================================================
{
    "Challenge 059, Task #1: Linked List (Raku)".put;

    while my Str $line = data()
    {
        my Real ($k, @values) = $line.split( /\s+/ ).map: { .Real };
        my       $origl-list  = LinkedList::Single.new( @values, NaN );
        my       $partd-list  = partition( $origl-list, $k );

        "\nOriginal list:        %s\n".printf:     sprint-list($origl-list);
         "Partitioned on k = %d: %s\n".printf: $k, sprint-list($partd-list);
    }
}

#-------------------------------------------------------------------------------
sub partition( $list, Real:D $k )
#-------------------------------------------------------------------------------
{
    my $left  = LinkedList::Single.new;
    my $right = LinkedList::Single.new;

    $list.head;
    my $data  = $list.each;

    until $data.isNaN
    {
       ($data < $k ?? $left !! $right).push: $data;
        $data = $list.each;
    }

    $right.push: NaN;
    $right.head;
    $data = $right.each;

    until $data.isNaN
    {
        $left.push: $data;
        $data = $right.each;
    }

    $left.push: NaN;

    return $left;
}

#-------------------------------------------------------------------------------
sub sprint-list( $list --> Str:D )
#-------------------------------------------------------------------------------
{
    my Real @array;

    $list.head;
    my $data = $list.each;

    until $data.isNaN
    {
        @array.push: $data;
        $data = $list.each;
    }

    return '%s'.sprintf: @array.join: ' -> ';
}

#-------------------------------------------------------------------------------
sub data( --> Str:D )
#-------------------------------------------------------------------------------
{
    state UInt $index = 0;
    state Str  @data  =
               [
                   '3  1 4 3 2 5 2',
                   '4  1 4 3 2 5 2',
                   '5  1 4 3 2 5 2',
                   '3  1 2 3 2 1',
                   '4  5 4 3 2 1',
                   '3  3 6 2 2 1 -1 17 5',
                   '0  5 4 3 2 1 0 -1 -2 -3 -4 -5',
                   '1  5 4 3 2 1 0 -1 -2 -3 -4 -5',
               ];

    return $index < @data.elems ?? @data[ $index++ ] !! Nil;
}

###############################################################################
