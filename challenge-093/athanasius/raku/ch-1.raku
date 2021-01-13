use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 093
=========================

Task #1
-------
*Max Points*

Submitted by: Mohammad S Anwar

You are given set of co-ordinates @N.

Write a script to count maximum points on a straight line when given co-
ordinates plotted on a 2-d plane.

Example 1:

 |
 |     *
 |   *
 | *
 + _ _ _ _

 Input: (1,1), (2,2), (3,3)
 Output: 3

Example 2:

 |
 |
 | *       *
 |   *
 | *   *
 + _ _ _ _ _

 Input: (1,1), (2,2), (3,1), (1,3), (5,3)
 Output: 3

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use lib '.';
use Line;

my Bool constant $VERBOSE = False;

my regex REAL { [ \+ || \- ]? <[ 0 .. 9 ]>+ [ \. <[ 0 .. 9 ]>+ ]? };

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 093, Task #1: Max Points (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@coords       #= Cartesian plane co-ordinates such as (1.5,-7) or (+3,0.2)
)
#==============================================================================
{
    my Pair @N;

    for @coords -> Str $pair
    {
        $pair ~~ rx{ ^ \( ( <REAL> ) \, ( <REAL> ) \) $ }
            or error( qq[Malformed coordinate pair "$pair"] );

        @N.push: $0.Num => $1.Num;
    }

    @N = sort-and-remove-duplicates( @N );

    "Input: %s\n"\.printf: @N.map( { sprintf '(%s,%s)', .kv } ).join: ', ';

    if (my Line $max-line = find-max-line( @N )).defined
    {
        "Output: %d%s\n".printf:
            $max-line.count-points,
            $VERBOSE ?? ', viz. ' ~ $max-line.show-points !! '';
    }
    else
    {
        'Output: 0'.put;
    }
}

#------------------------------------------------------------------------------
sub find-max-line( Pair:D @N --> Line )
#------------------------------------------------------------------------------
{
    my Line $max-line;

    if @N.elems >= 2
    {
        my Line @lines;

        for 0 .. @N.end - 1 -> UInt $i
        {
            for $i + 1 .. @N.end -> UInt $j
            {
                my Bool $found    = False;
                my Line $new-line = Line.new\
                                    (
                                        x1 => @N[$i].key, y1 => @N[$i].value,
                                        x2 => @N[$j].key, y2 => @N[$j].value,
                                    );

                for @lines -> Line $existing-line
                {
                    if $new-line.collinear( $existing-line )
                    {
                        $existing-line.add-point( @N[$j] );
                        $found = True;
                        last;
                    }
                }

                @lines.push: $new-line unless $found;
            }
        }

        my UInt $max-count = 0;

        for @lines -> Line $line
        {
            if (my UInt $count = $line.count-points) > $max-count
            {
                $max-count = $count;
                $max-line  = $line;
            }
        }
    }

    return $max-line;
}

#------------------------------------------------------------------------------
sub sort-and-remove-duplicates( Pair:D @N --> Array:D[Pair:D] )
#------------------------------------------------------------------------------
{
    my Pair @sorted = @N.sort: { $^a.key   <=> $^b.key ||
                                 $^a.value <=> $^b.value };
    my Pair @unique;
    my Pair $last;

    for @sorted -> $point
    {
        if $point === $last
        {
            "WARNING: Duplicate point ({ $point.key },{ $point.value })".note;
        }
        else
        {
            @unique.push: $point;
        }

        $last = $point;
    }

    return @unique;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;
    USAGE();

    exit;
}

##############################################################################
