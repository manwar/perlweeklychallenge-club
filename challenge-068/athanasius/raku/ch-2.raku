use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 068
=========================

Task #2
-------
*Reorder List*

*Submitted by:* Mohammad S Anwar

You are given a singly linked list $L as below:

 L0 →  L1 →  … →  Ln-1 →  Ln

Write a script to reorder list as below:

 L0 →  Ln →  L1 →  Ln-1 →  L2 →  Ln-2 → […]

You are *ONLY* allowed to do this in-place without altering the nodes' values.

*Example*

 Input:  1 →  2 →  3 →  4
 Output: 1 →  4 →  2 →  3

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use lib < . >;
use SinglyLinkedList;

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
multi sub MAIN
(
    #| (UInt > 0) Num. of elements (with values 1, 2, 3, ...)
    UInt:D $num-elements where { $num-elements > 0 }
)
#===============================================================================
{
    main(1 .. $num-elements);
}

#===============================================================================
multi sub MAIN
(
    #| (Str+) Explicit element values, in order
    *@elements where { @elements.elems > 0 }
)
#===============================================================================
{
    main(@elements);
}

#-------------------------------------------------------------------------------
sub main(*@elements)                #= List elements, in order
#-------------------------------------------------------------------------------
{
    "Challenge 068, Task #2: Reorder List (Raku)\n".put;

    my $L = SinglyLinkedList.new;

    $L.append(.Str) for @elements;

    $L.print('Input:  ');

    reorder-list($L);

    $L.print('Output: ');
}

#-------------------------------------------------------------------------------
sub reorder-list(SinglyLinkedList:D $list)
#-------------------------------------------------------------------------------
{
    loop (my Hash $current = $list.head;
                  $current{'next'} && $current{'next'}{'next'};
                  $current = $current{'next'}{'next'})
    {
        $list.insert($current, $list.remove-tail);
    }
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
