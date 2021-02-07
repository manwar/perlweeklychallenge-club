use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 098
=========================

Task #2
-------
*Search Insert Position*

Submitted by: Mohammad S Anwar

You are given a sorted array of distinct integers @N and a target $N.

Write a script to return the index of the given target if found otherwise place
the target in the sorted array and return the index.

Example 1:

 Input: @N = (1, 2, 3, 4) and $N = 3
 Output: 2 since the target 3 is in the array at the index 2.

Example 2:

 Input: @N = (1, 3, 5, 7) and $N = 6
 Output: 3 since the target 6 is missing and should be placed at the index 3.

Example 3:

 Input: @N = (12, 14, 16, 18) and $N = 10
 Output: 0 since the target 10 is missing and should be placed at the index 0.

Example 4:

 Input: @N = (11, 13, 15, 17) and $N = 19
 Output: 4 since the target 19 is missing and should be placed at the index 4.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

The index search is implemented using Raku's built-in List::first() method with
the named parameter :k. Note that first() "returns Nil when no values match",
which happens only when $N comes after the last list element. To handle this
case, the returned index is tested for definedness: an undefined value is re-
placed with the index one greater than the currently-highest list index.

Note: The Task description specifies:

    "Write a script to return the index of the given target if found otherwise
     place the target in the sorted array and return the index."

However, as the output required is the index only, there seems no point in
actually *inserting* $N into the array in the case where $N does not already
occur in @N. I interpret the Task description to mean "otherwise return the
index which $N would have if inserted into @N."

=end comment
#==============================================================================

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 098, Task #2: Search Insert Position (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:D :$N,     #= The target integer

    #| A sorted list of distinct integers

    *@N where { .all ~~ Int:D && distinct-and-ordered( @N ) }
)
#==============================================================================
{
    "Input:  @N = (%s) and \$N = %d\n".printf: @N.join(', '), $N;

    my Str  $msg = 'in the array';
    my UInt $idx = @N.first( * == $N, :k );

    unless $idx.defined
    {
        $msg = 'missing and should be placed';
        $idx = @N.first( * > $N, :k ) // @N.end + 1;
    }

    "Output: $idx%s\n".printf:
        $VERBOSE ?? " since the target $N is $msg at the index $idx" !! '';
}

#------------------------------------------------------------------------------
sub distinct-and-ordered( Array:D[Int:D] $array --> Bool )
#------------------------------------------------------------------------------
{
    if $array.elems > 0
    {
        my Int $previous = $array[ 0 ];

        for 1 .. $array.end -> Int $i
        {
            my Int $current = $array[ $i ];

            return False if $previous >= $current;

            $previous = $current;
        }
    }

    return True;
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
