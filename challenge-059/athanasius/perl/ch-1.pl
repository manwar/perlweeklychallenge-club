#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use LinkedList::Single;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 059, Task #1: Linked List (Perl)\n";

    while (my $line = <DATA>)
    {
        my ($k, @values) = split /\s+/, $line;
        my  $origl_list  = LinkedList::Single->new(@values);
        my  $partd_list  = partition($origl_list, $k);

        printf "\nOriginal list:        %s\n",     sprint_list($origl_list);
        printf  "Partitioned on k = %d: %s\n", $k, sprint_list($partd_list);
    }
}

#-------------------------------------------------------------------------------
sub partition
#-------------------------------------------------------------------------------
{
    my ($list, $k) = @_;
    my  $left      = LinkedList::Single->new;
    my  $right     = LinkedList::Single->new;

    $list->head;

    while (my @data = $list->each)
    {
        ($data[0] < $k ? $left : $right)->push( @data );
    }

    $right->head;

    while (my @data = $right->each)
    {
        $left->push( @data );
    }

    return $left;
}

#-------------------------------------------------------------------------------
sub sprint_list
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  @array;

    $list->head;
 
    while (my @data = $list->each)
    {
        push @array, @data;
    }

    return sprintf '%s', join ' -> ', @array;
}

################################################################################

#-------------------------------------------------------------------------------
# Sample data with format: _k_ followed by the linked list values
#-------------------------------------------------------------------------------

__DATA__
3  1 4 3 2 5 2
4  1 4 3 2 5 2
5  1 4 3 2 5 2
3  1 2 3 2 1
4  5 4 3 2 1
3  3 6 2 2 1 -1 17 5
0  5 4 3 2 1 0 -1 -2 -3 -4 -5
1  5 4 3 2 1 0 -1 -2 -3 -4 -5
