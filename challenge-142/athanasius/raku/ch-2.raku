use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 142
=========================

TASK #2
-------
*Sleep Sort*

Submitted by: Adam Russell

Another joke sort similar to JortSort suggested by champion Adam Russell.

You are given a list of numbers.

Write a script to implement Sleep Sort. For more information, please checkout
this [ https://iq.opengenus.org/sleep-sort |post].

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Configuration
-------------
Sleep Sort's performance is governed by the value assigned to the constant
$INTERVAL, and involves a tradeoff between speed and accuracy: the smaller the
value, the faster the sort will complete but the greater the chance that some
of the values will be out of their correct sort order.

Output
------
1. The sorted output is shown progressively, each value being displayed as it
   is found.
2. The input values are not restricted to integers: all non-negative real num-
   bers are accepted. This makes it more difficult to determine a practical
   value for $INTERVAL, as the minimum setting required to ensure accurate
   sorting depends on the smallest difference between non-identical numbers.
   For example, on my machine the integers 9, 2, 7, 0, 1, 5, 4, 8, 9, 0
   (minimum difference 1) are correctly sorted when $INVERVAL is set to 1, but
   correct sorting of the real numbers 9.2, 2, 7, 0, 1, 5, 4, 8.5, 9, 0
   (minimum difference 0.2) requires $INTERVAL to be set to at least 3.4.

=end comment
#==============================================================================

my Real constant $INTERVAL = 1;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 142, Task #2: Sleep Sort (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| A list of non-negative real numbers

    *@numbers where { .all ~~ Real:D && .all >= 0 }
)
#==============================================================================
{
    "Input:  %s\n".printf: @numbers.join: ', ';
    'Output: '.print;

    my Channel $chan = Channel.new;

    for @numbers -> Real $n
    {
        start
        {
            sleep $n * $INTERVAL if $n > 0;
            $chan.send: $n;
        }
    }

    my Bool $first = True;

    loop (my UInt $count = 0; $count < @numbers.elems; )
    {
        my Str $item = $chan.poll;

        if $item.defined
        {
            ', '.print unless $first;
            $item.print;
            ++$count;
            $first = False;
        }
    }

    put();
    $chan.close;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
