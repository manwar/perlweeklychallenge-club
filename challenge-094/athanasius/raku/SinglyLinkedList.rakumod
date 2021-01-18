use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 094, Task #2: Binary Tree to Linked List

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
unit class SinglyLinkedList;
#==============================================================================

#------------------------------------------------------------------------------
my class Node
#------------------------------------------------------------------------------
{
    has Any  $.value;
    has Node $.next is rw;
}

has Node $.head is rw;

#------------------------------------------------------------------------------
submethod BUILD( :$value )
#------------------------------------------------------------------------------
{
    if $value.defined
    {
        $!head = Node.new( value => $value, next => Nil );
    }
}

#------------------------------------------------------------------------------
method append( Any $value )
#------------------------------------------------------------------------------
{
    if $value.defined && $value ne ''
    {
        my Node $new-node = Node.new( value => $value, next => Nil );

        if $!head.defined
        {
            my Node $current = $!head;

            $current = $current.next while $current.next.defined;
        
            $current.next = $new-node;
        }
        else
        {
            $!head = $new-node;
        }
    }
}

#------------------------------------------------------------------------------
method display( --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $display;

    if $!head.defined
    {
        my Bool $first = True;

        loop (my Node $node = $!head; $node.defined; $node = $node.next)
        {
            $display ~= ' -> ' unless $first;
            $first    = False;
            $display ~= $node.value;
        }
    }
    else
    {
        $display = '(empty)';
    }

    return $display;
}

##############################################################################
