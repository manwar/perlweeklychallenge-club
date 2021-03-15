use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 095, Task #2: Demo Stack

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
unit class Stack;
#==============================================================================

#------------------------------------------------------------------------------
# Exception classes
#------------------------------------------------------------------------------

class Empty is Exception { }

class Empty::Pop is Stack::Empty
{
    method message() { 'ERROR: Cannot pop() an empty stack'; }
}

class Empty::Top is Stack::Empty
{
    method message() { 'ERROR: There is no top() on an empty stack'; }
}

class Empty::Min is Stack::Empty
{
    method message() { 'ERROR: There is no min() for an empty stack'; }
}

#------------------------------------------------------------------------------
# Stack attributes
#------------------------------------------------------------------------------

has Bool   $!throw;
has Int:D  $!top = -1;  # Index of the top element: -1 indicates an empty stack
has Real:D @!items;

#------------------------------------------------------------------------------
submethod BUILD( Bool:D :$throw = True )
#------------------------------------------------------------------------------
{
    $!throw = $throw;
}

#------------------------------------------------------------------------------
method push( Real:D $item )
#------------------------------------------------------------------------------
{
    @!items.push: $item;
    ++$!top;
}

#------------------------------------------------------------------------------
method pop( --> Real )
#------------------------------------------------------------------------------
{
    my Real $item;

    if $!top >= 0
    {
        $item = @!items.pop;
        --$!top;
    }
    elsif $!throw
    {
        Empty::Pop.new.throw;
    }

    return $item;
}

#------------------------------------------------------------------------------
method top( --> Real )
#------------------------------------------------------------------------------
{
    my Real $item;

    if $!top >= 0
    {
        $item = @!items[ $!top ];
    }
    elsif $!throw
    {
        Empty::Top.new.throw;
    }

    return $item;
}

#------------------------------------------------------------------------------
method min( --> Real )
#------------------------------------------------------------------------------
{
    my Real $min;

    if $!top >= 0
    {
        $min = @!items[ 0 ];

        for 1 .. @!items.end -> UInt $i
        {
            my Real $new-min = @!items[ $i ];

            $min  = $new-min if $new-min < $min;
        }
    }
    elsif $!throw
    {
        Empty::Min.new.throw;
    }

    return $min;
}

#------------------------------------------------------------------------------
method display( --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $stack = "Stack: (empty)\n";

    if $!top >= 0
    {
        my UInt $width = @!items[ $!top ].chars;

        for @!items[ 0 .. $!top - 1 ] -> Real $item
        {
            my UInt  $new-width = $item.chars;

            $width = $new-width if $new-width > $width;
        }

        my Bool $top = True;
        my Str  $bar = '+-%s-+'.sprintf: '-' x $width;

        $stack = "Stack: $bar\n";

        for @!items.reverse -> Real $item
        {
            $stack ~= "       | %*s |%s\n       %s\n".sprintf:
                      $width, $item, $top ?? ' <- top' !! '', $bar;

            $top = False;
        }
    }

    return $stack;
}

##############################################################################
