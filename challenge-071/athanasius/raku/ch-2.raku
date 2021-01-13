use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 071
=========================

Task #2
-------
*Trim Linked List*

*Submitted by:* Mohammad S Anwar

You are given a singly linked list and a positive integer _$N_ (>0).

Write a script to remove the _$Nth_ node from the end of the linked list and
print the linked list.

If _$N_ is greater than the size of the linked list then remove the first node
of the list.

NOTE: Please use pure linked list implementation.

*Example*

Given Linked List: 1 -> 2 -> 3 -> 4 -> 5

when $N = 1
Output: 1 -> 2 -> 3 -> 4

when $N = 2
Output: 1 -> 2 -> 3 -> 5

when $N = 3
Output: 1 -> 2 -> 4 -> 5

when $N = 4
Output: 1 -> 3 -> 4 -> 5

when $N = 5
Output: 2 -> 3 -> 4 -> 5

when $N = 6
Output: 2 -> 3 -> 4 -> 5

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#*******************************************************************************
=begin comment

For a doubly-linked list, counting backwards from the tail of the list would be
straightforward. For a singly-linked list, it is necessary to first know the
total number of elements in the list (i.e., its size); once this is known, it is
easy to find the required node by counting forwards from the head.

One way to find the list size is to traverse the whole list from head to tail,
counting the traversals. For long lists, this could be a costly procedure. The
following SinglyLinkedList implementation therefore adds a "$!elems" attribute
which records the list size. This value is maintained by ensuring that it is
 - incremented on each call to append() or insert()
 - decremented on each call to remove().

Note: The implementation provided for SinglyLinkedList is only the minimum
needed for this Task. Method insert() is omitted. A robust implementation would
also provide a dedicated iterator for list traversal.

=end comment
#*******************************************************************************

#===============================================================================
class Node
#===============================================================================
{
    has Str  $.datum is required;
    has Node $.next  is rw = Nil;
}

#===============================================================================
class SinglyLinkedList
#===============================================================================
{
    has UInt $.elems = 0;                                            # List size
    has Node $.head  = Node.new: datum => 'HEAD';                    # Sentinel

    #---------------------------------------------------------------------------
    method append(Str:D $element --> SinglyLinkedList:D)
    #---------------------------------------------------------------------------
    {
        my Node $node         = Node.new: datum => $element;
        my Node $current      = $!head;
                $current      = $current.next while $current.next;
                $current.next = $node;

        ++$!elems;

        return self;                                       # Facilitate chaining
    }

    #---------------------------------------------------------------------------
    method remove(Node:D $preceding --> SinglyLinkedList:D)
    #---------------------------------------------------------------------------
    {
        my Node $target;

        if $preceding.next
        {
            $target         = $preceding.next;
            $preceding.next = $target.next;

            --$!elems;
        }
        else                                               # Sanity check only
        {
            $!elems == 0 or die "ERROR: \$!elems = $!elems, should be 0";
        }

        return self;                                       # Facilitate chaining
    }

    #---------------------------------------------------------------------------
    method print(Str:D $title)
    #---------------------------------------------------------------------------
    {
        "$title [$!elems]: ".print;

        if $!elems > 0
        {
            (my Node $current = $!head.next).datum.print;
            " -> { $current.datum }".print while $current = $current.next;
            ''.put;
        }
        else
        {
            '<empty>'.put;
        }
    }
}

################################################################################

subset Natural of UInt where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 071, Task #2: Trim Linked List (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    Natural:D :$N,    #= No. of the node to remove, counting from the list end
    UInt:D    :$S,    #= List size: elements will have values '1', '2', ..., 'S'
)
#===============================================================================
{
    main($N, 1 .. $S);
}

#===============================================================================
multi sub MAIN
(
    Natural:D :$N,
              *@elements,         #= Explicit element values (strings), in order
)
#===============================================================================
{
    main($N, @elements);
}

#-------------------------------------------------------------------------------
sub main(Natural:D $N, *@elements)
#-------------------------------------------------------------------------------
{
    # 1. Build and display the linked list

    my SinglyLinkedList $list = SinglyLinkedList.new;

    $list.append: .Str for @elements;
    $list.print:  'Input ';

    # 2. Remove the Nth-last element and display the resulting list

    my Int  $diff  = $list.elems - $N;
    my UInt $count = $diff < 0 ?? 0 !! $diff;
    my Node $prev  = $list.head;
            $prev  = $prev.next for 1 .. $count;

    $list.remove($prev)
         .print: "N = $N\nOutput";
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
