use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 148
=========================

TASK #1
-------
*Eban Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate all Eban Numbers <= 100.

    An Eban number is a number that has no letter 'e' in it when the number is
    spelled in English (American or British).

Example

 2, 4, 6, 30, 32 are the first 5 Eban numbers.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
Eban numbers are a subset of the natural numbers.

Solution
--------
The solution is based on lists of the 28 names required to spell the integers 1
to 100 in English.

Output
------
The output defaults to a list of Eban numbers, as shown in the Example. For a
more detailed output showing the English names of the Eban numbers, set the
constant $VERBOSE to True.

References
----------
https://oeis.org/A006933
https://en.wikipedia.org/wiki/Ban_number

=end comment
#==============================================================================

subset Pos of Int where * > 0;

my UInt constant $MAX-EBAN     =   100;
my      constant @SINGLE-NAMES = < '' one two three four five six seven eight
                                   nine ten eleven twelve thirteen fourteen
                                   fifteen sixteen seventeen eighteen
                                   nineteen >;
my      constant @PREFIX-NAMES = < '' '' twenty thirty forty fifty sixty
                                   seventy eighty ninety >;
my Str  constant $ONE-HUNDRED  =   'one hundred';
my Bool constant $VERBOSE      =   False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 148, Task #1: Eban Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my Pos @eban-nums;

    for 1 .. 19 -> Pos $n
    {
        @eban-nums.push: $n unless @SINGLE-NAMES[ $n ] ~~ /e/;
    }

    for 2 .. 9 -> Pos $p
    {
        next if @PREFIX-NAMES[ $p ] ~~ /e/;

        for 0 .. 9 -> UInt $n
        {
            @eban-nums.push: $p * 10 + $n unless @SINGLE-NAMES[ $n ] ~~ /e/;
        }
    }

    @eban-nums.push: 100 unless $ONE-HUNDRED ~~ /e/;

    "There are %d Eban numbers <= %d:\n".printf: @eban-nums.elems, $MAX-EBAN;

    if $VERBOSE
    {
        " %3d. %s\n".printf: $_, get-name( $_ ) for @eban-nums;
    }
    else
    {
        "%s\n".printf: @eban-nums.join: ', ';
    }
}

#------------------------------------------------------------------------------
sub get-name( Pos:D $n --> Str:D )
#------------------------------------------------------------------------------
{
    my Str $name;

    if $n < 20
    {
        $name  = @SINGLE-NAMES[ $n ];
    }
    elsif $n < 100
    {
        $name  = @PREFIX-NAMES[ $n / 10 ];
        $name ~= '-' ~
                 @SINGLE-NAMES[ $n % 10 ] if $n % 10 > 0;
    }
    else
    {
        $name  = $ONE-HUNDRED;
    }

    return $name;
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
