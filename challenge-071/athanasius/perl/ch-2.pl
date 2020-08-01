#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#*******************************************************************************
=comment

For a doubly-linked list, counting backwards from the tail of the list would be
straightforward. For a singly-linked list, it is necessary to first know the
total number of elements in the list (i.e., its size); once this is known, it is
easy to find the required node by counting forwards from the head.

One way to find the list size is to traverse the whole list from head to tail,
counting the traversals. For long lists, this could be a costly procedure. The
following SinglyLinkedList implementation therefore adds an "elems" attribute
which records the list size. This value is maintained by ensuring that it is
 - incremented on each call to append() or insert()
 - decremented on each call to remove().

Note: The implementation provided for SinglyLinkedList is only the minimum
needed for this Task. Method insert() is omitted. A robust implementation would
also provide a dedicated iterator for list traversal.

=cut
#*******************************************************************************

#===============================================================================
package Node
#===============================================================================
{
    use Moose;
    use MooseX::LvalueAttribute;
    use namespace::autoclean;
 
    has datum =>
    (
        is       =>  'ro',
        isa      =>  'Str',
        required =>   1,
    );

    has next =>
    (
        traits   => ['Lvalue'],
        is       =>  'rw',
        isa      =>  'Maybe[Node]',
        default  =>   undef,
    );

    no Moose;
    __PACKAGE__->meta->make_immutable;
}

#===============================================================================
package SinglyLinkedList
#===============================================================================
{
    use Moose;
    use Moose::Util::TypeConstraints;
    use MooseX::LvalueAttribute;
    use namespace::autoclean;

    subtype 'UInt',
        as   'Int',
        where { $_ >= 0 };

    has elems =>                # List size
    (
        traits  => ['Lvalue'],
        is      =>  'rw',
        isa     =>  'UInt',
        default =>   0,
    );

    has head =>                 # Sentinel
    (
        is      =>  'ro',
        isa     =>  'Node',
        default =>   sub { Node->new(datum => 'HEAD') },
    );

    #---------------------------------------------------------------------------
    sub append
    #---------------------------------------------------------------------------
    {
        my ($self, $element) = @_;
        my  $node            = Node->new(datum => $element);
        my  $current         = $self->head;
            $current         = $current->next while $current->next;
            $current->next   = $node;

        ++$self->elems;

        return $self;           # Facilitate chaining
    }

    #---------------------------------------------------------------------------
    sub remove
    #---------------------------------------------------------------------------
    {
        my ($self, $preceding) = @_;
        my  $target;

        $preceding or die "ERROR: Invalid 'preceding' node passed to remove()";

        if ($preceding->next)
        {
            $target          = $preceding->next;
            $preceding->next = $target->next;

            --$self->elems;
        }
        else                    # Sanity check only
        {
            $self->elems == 0
                   or die 'ERROR: elems = ' . $self->elems . ', should be 0';
        }

        return $self;           # Facilitate chaining
    }

    #---------------------------------------------------------------------------
    sub print
    #---------------------------------------------------------------------------
    {
        my ($self, $title) = @_;

        printf '%s [%d]: ', $title, $self->elems;

        if ($self->elems > 0)
        {
            my $current = $self->head->next;

            print $current->datum;
            printf ' -> %s', $current->datum while $current = $current->next;
            print "\n";
        }
        else
        {
            print "<empty>\n";
        }
    }

    no Moose;
    __PACKAGE__->meta->make_immutable;
}

################################################################################

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [-N <Natural>] [-S <UInt>]
  perl $0 [-N <Natural>] [<elements> ...]

    -N <Natural>        No. of the node to remove, counting from the list end
    -S <UInt>           List size: elements will have values 1, 2, 3, ..., S
    [<elements> ...]    Explicit element values (strings), in order\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 071, Task #2: Trim Linked List (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my ($N, $elements) = parse_command_line();

    # 1. Build and display the linked list

    my $list = SinglyLinkedList->new;
       $list->append($_) for @$elements;
       $list->print('Input ');

    # 2. Remove the Nth-last element and display the resulting list

    my $diff  = $list->elems - $N;
    my $count = $diff < 0 ? 0 : $diff;
    my $prev  = $list->head;
       $prev  = $prev->next for 1 .. $count;

    $list->remove($prev)
         ->print("N = $N\nOutput");
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($N, $S);

    GetOptions('N=i' => \$N, 'S:i' => \$S)             or die $USAGE;

    my @elements = @ARGV;

    defined $N && $N =~ /\A$RE{num}{int}\z/ && $N >  0 or die $USAGE;

    if (defined $S)
    {
        scalar @elements == 0 &&
                  $S =~ /\A$RE{num}{int}\z/ && $S >= 0 or die $USAGE;

        @elements = 1 .. $S;
    }

    return ($N, \@elements);
}

################################################################################
