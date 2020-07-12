use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 068
=========================

Task #2
-------
*Reorder List*

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
unit class SinglyLinkedList;
#===============================================================================

has $.head = Nil;

#-------------------------------------------------------------------------------
method append(Str:D $element)
#-------------------------------------------------------------------------------
{
    my %node = datum => $element, next => Nil;

    if $!head
    {
        my Hash $current = $!head;

        $current = $current{'next'} while $current{'next'};

        $current{'next'} = %node;
    }
    else
    {
        $!head = %node;
    }
}

#-------------------------------------------------------------------------------
method remove-tail(--> Hash:D)
#-------------------------------------------------------------------------------
{
    my Hash $tail;
    my Hash $current = $!head;

    if $current
    {
        if $current{'next'}
        {
            $current = $current{'next'}
                 while $current{'next'} && $current{'next'}{'next'};

            $tail = $current{'next'};

            $current{'next'} = Nil;
        }
        else
        {
            $tail  = $current;
            $!head = Nil;
        }
    }

    return $tail;
}

#-------------------------------------------------------------------------------
method insert(Hash:D $current, Hash:D $node-to-add)
#-------------------------------------------------------------------------------
{
    my $old-next;

    if $!head && $current
    {
        $old-next        = $current{'next'};
        $current{'next'} = $node-to-add;
    }
    else
    {
        $old-next        = $!head;
        $!head           = $node-to-add;
    }

    $node-to-add{'next'} = $old-next;
}

#-------------------------------------------------------------------------------
method print(Str:D $title)
#-------------------------------------------------------------------------------
{
    $title.print if $title;

    if $!head
    {
        my $current = $!head;

        while $current
        {
            $current{'datum'}.print;
            $current = $current{'next'};
           ($current ?? ' -> ' !! "\n").print;
        }
    }
    else
    {
        '<empty>'.put;
    }
}

################################################################################
